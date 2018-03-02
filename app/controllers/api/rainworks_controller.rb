module Api
  class RainworksController < ApplicationController
    before_action :set_rainwork, only: [:show]

    # GET /api/active-rainworks
    def active_rainworks
      @rainworks = Rainwork.all.where(
        approval_status: :accepted
      ).select(*public_fields)

      render json: @rainworks
    end

    def index
      active_rainworks
    end

    def list_submissions
      @rainworks = Rainwork.all.where(
        device_id: params[:device_id]
      ).select(*submission_fields)

      render json: @rainworks
    end

    # POST /api/rainworks
    def create
      @rainwork = Rainwork.new(rainwork_params)

      filename = SecureRandom.uuid
      object = S3_BUCKET.object(filename)
      upload_url = object.presigned_url(:put, acl: 'public-read')

      @rainwork.image_url = object.public_url

      # TODO: Do we want to have a confirmation step after the image is uploaded?
      # TODO: Email notification

      if @rainwork.save
        response = {
          image_upload_url: upload_url,
        }
        render json: response, status: :created
      else
        render json: rainwork.errors, status: :unprocessable_entity
      end
    end

    private
    # Fields to return to general public
    def public_fields
      [:id, :created_at, :creator_name, :description, :lat, :lng, :name, :updated_at, :image_url]
    end

    # Fields to return for a user's submission
    def submission_fields
      public_fields + [
        :approval_status
      ]
    end

    # Only allow a trusted parameter "white list" through.
    def rainwork_params
      params.require([:name, :lat, :lng, :device_id])
      params.permit(:name, :lat, :lng, :device_id, :creator_name, :creator_email, :description)
    end
  end
end
