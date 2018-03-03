module Api
  class DevicesController < ApplicationController
    def update
      @device = Device.find_or_create_by(device_uuid: params.require(:device_uuid))
      
      @device.push_token = params.require(:push_token)

      if @device.save
        render json: @device, status: :created
      else
        render json: @device.errors, status: :unprocessable_entity
      end
    end

    private
    def device_params
      params.require(:device_uuid)
      params.permit(:device_uuid)
    end
  end
end
