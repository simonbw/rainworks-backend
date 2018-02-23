class RainworksController < ApplicationController
  before_action :set_rainwork, only: [:show]

  # GET /rainworks
  def index
    rainworks = Rainwork.all

    render json: @rainworks
  end

  # GET /rainworks/1
  def show
    @rainwork = Rainwork.find(params[:id])
    render json: @rainwork
  end

  # POST /rainworks
  def create
    @rainwork = Rainwork.new(rainwork_params)

    # TODO: Email notification
    
    if @rainwork.save
      render json: @rainwork, status: :created, location: @rainwork
    else
      render json: @rainwork.errors, status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def rainwork_params
    params.require(:rainwork, :name, :lat, :lng).permit(:creator_name, :creator_email, :description, :image_url)
  end
end
