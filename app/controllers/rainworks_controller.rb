class RainworksController < ApplicationController
  before_action :set_rainwork, only: [:show]

  # GET /rainworks
  def index
    rainworks = Rainwork.all.where(
      active: true,
      approval_status: :accepted
    ).select(
      :id,
      :created_at,
      :creator_name,
      :description,
      :lat,
      :lng,
      :name,
      :updated_at,
      :image_url,
    )

    render json: rainworks
  end

  # GET /rainworks/1
  def show
    rainwork = Rainwork.find(params[:id])
    render json: rainwork
  end

  # POST /rainworks
  def create
    rainwork = Rainwork.new(rainwork_params)

    filename = SecureRandom.uuid
    object = S3_BUCKET.object(filename)
    presigned_post = object.presigned_post()

    rainwork.image_url = object.public_url

    # TODO: Do we want to have a confirmation step after the image is uploaded?
    # TODO: Email notification

    if rainwork.save
      response = {
        image_upload_url: presigned_post.url,
      }
      render json: response, status: :created, location: rainwork
    else
      render json: rainwork.errors, status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def rainwork_params
    params.require([:name, :lat, :lng])
    params.permit(:name, :lat, :lng, :creator_name, :creator_email, :description)
  end
end
