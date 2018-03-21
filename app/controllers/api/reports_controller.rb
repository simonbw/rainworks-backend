module Api
  class ReportsController < ApplicationController

    def index
      @device = Device.find_or_create_by!(device_uuid: params.require(:device_uuid))
      @reports = @device.reports
      render json: @reports
    end

    def create
      @report = Report.new(report_params)
      @report.device = Device.find_or_create_by(device_uuid: params.require(:device_uuid))

      if @report.inappropriate? or @report.faded?
        filename = SecureRandom.uuid
        object = S3_BUCKET.object(filename)
        upload_url = object.presigned_url(:put, acl: 'public-read')
        @report.image_url = object.public_url
      end

      if @report.save
        if !@report.found_it?
          NotificationsMailer.report_alert(@report).deliver_later
        end
        response = { :report => @report }
        if (upload_url) then response[:image_upload_url] = upload_url end
        render json: response, status: :created
      else
        render json: @report.errors, status: :unprocessable_entity
      end
    end

    private
    def report_params
      params.require([:device_uuid, :rainwork_id, :report_type])
      params.permit(:rainwork_id, :report_type, :description)
    end
  end
end
