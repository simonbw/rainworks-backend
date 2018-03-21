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

      if @report.save
        if !@report.found_it?
          NotificationsMailer.report_alert(@report).deliver_later
        end
        render json: @report, status: :created
      else
        render json: @report.errors, status: :unprocessable_entity
      end
    end

    private
    def report_params
      params.require([:device_uuid, :rainwork_id, :report_type])
      params.permit(:rainwork_id, :report_type)
    end
  end
end
