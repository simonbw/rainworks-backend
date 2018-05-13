module Api
  class RainworksController < ApplicationController
    # GET /api/rainworks
    def index
      # TODO: Don't include rainworks that are expired and don't show on the gallery
      @rainworks = Rainwork.where(
        approval_status: [:accepted, :expired]
      ).select(*public_fields)

      render json: @rainworks
    end

    def show
      @rainwork = Rainwork.select(*public_fields).find(params.require(:id))

      render json: @rainwork
    end

    private
    # Fields to return to general public
    def public_fields
      [
        :id,
        :approval_status,
        :creator_name,
        :installation_date,
        :description,
        :lat,
        :lng,
        :name,
        :updated_at,
        :image_url,
        :thumbnail_url,
        :found_it_count,
        :show_in_gallery
      ]
    end
  end
end
