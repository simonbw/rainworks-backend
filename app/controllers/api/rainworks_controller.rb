module Api
  class RainworksController < ApplicationController
    # GET /api/rainworks
    def index
      @rainworks = Rainwork.where(
        approval_status: :accepted
      ).select(*public_fields)

      render json: @rainworks
    end

    private
    # Fields to return to general public
    def public_fields
      [:id, :created_at, :creator_name, :description, :lat, :lng, :name, :updated_at, :image_url, :found_it_count]
    end
  end
end
