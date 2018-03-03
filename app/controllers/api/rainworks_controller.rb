module Api
  class RainworksController < ApplicationController
    # GET /api/active-rainworks
    def active_rainworks
      @rainworks = Rainwork.all.where(
        approval_status: :accepted
      ).select(*public_fields)

      render json: @rainworks
    end

    # GET /api/submissions
    def list_submissions
      @rainworks = Rainwork.all.where(
        device_id: params[:device_id]
      ).select(*submission_fields)

      render json: @rainworks
    end

    # POST /api/submissions
    def create
      @rainwork = Rainwork.new(rainwork_params)

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

    # POST /api/report
    def create_report
      @report = Report.new(report_params)

      if @report.save
        NotificationsMailer.report_alert(@report).deliver_later
        render json: @report, status: :created
      else
        render json: @report.errors, status: :unprocessable_entity
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

    def report_params
      params.require([:device_id, :rainwork_id, :report_type])
      params.permit(:device_id, :rainwork_id, :report_type)
    end
  end
end
