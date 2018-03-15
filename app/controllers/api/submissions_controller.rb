module Api
  class SubmissionsController < ApplicationController
    # GET /api/submissions
    def index
      @device = Device.find_or_create_by!(device_uuid: params.require(:device_uuid))

      @rainworks = @device.rainworks.select(*submission_fields)

      render json: @rainworks
    end

    # POST /api/submissions
    def create
      @rainwork = Rainwork.new(submission_params)
      @rainwork.device = Device.find_or_create_by(device_uuid: params.require(:device_uuid))

      filename = SecureRandom.uuid
      object = S3_BUCKET.object(filename)
      upload_url = object.presigned_url(:put, acl: 'public-read')

      @rainwork.image_url = object.public_url

      # TODO: Do we want to have a confirmation step after the image is uploaded?

      if @rainwork.save
        NotificationsMailer.submission_alert(@rainwork).deliver_later
        response = {
          image_upload_url: upload_url,
        }
        render json: response, status: :created
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    private
    def submission_params
      params.require([:name, :lat, :lng, :installation_date])
      params.permit(:name, :lat, :lng, :installation_date, :creator_name, :creator_email, :description)
    end

    # Fields to return for a user's submission
    def submission_fields
      [:id, :approval_status, :created_at, :installation_date, :creator_name, :description, :lat, :lng, :name, :updated_at, :image_url, :report_count, :found_it_count, :missing_count, :faded_count, :inappropriate_count, :rejection_reason]
    end
  end
end
