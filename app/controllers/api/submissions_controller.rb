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
      @rainwork.device = Device.find_or_create_by!(device_uuid: params.require(:device_uuid))

      if @rainwork.device.initial_submission_status == 'accepted'
        @rainwork.approval_status = 'accepted'
      elsif @rainwork.device.initial_submission_status == 'rejected'
        @rainwork.approval_status = 'rejected'
      end

      # TODO: This really should be async
      filename = SecureRandom.uuid
      object = S3_BUCKET.object(filename)
      upload_url = object.presigned_url(:put, acl: 'public-read')
      @rainwork.image_url = object.public_url

      # TODO: Do we want to have a confirmation step after the image is uploaded?

      if @rainwork.save
        response = {
          image_upload_url: upload_url,
          finalize_url: finalize_api_submission_url(@rainwork)
        }
        render json: response, status: :created
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/submissions
    def destroy
      @rainwork = Rainwork.find(params.require(:id)).destroy

      render json: {status: 'Deleted', messsage: 'Rainwork deleted'}
    end

    # PUT /api/submissions/:id/expire TO EXPIRE
    def expire
      @rainwork = Rainwork.find(params[:id])

      @rainwork.approval_status = :expired

      if @rainwork.save
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    # PUT /api/submissions/:id TO UPDATE
    def update
      @rainwork = Rainwork.find(params[:id])
      @rainwork.approval_status = :edit_pending

       # TODO: This really should be async
       filename = SecureRandom.uuid
       object = S3_BUCKET.object(filename)
       upload_url = object.presigned_url(:put, acl: 'public-read')
       @rainwork.image_url = object.public_url

      if @rainwork.update_attributes(submission_params)
        response = {
          image_upload_url: upload_url,
          improve_url: improve_api_submission_url(@rainwork)
        }
        render json:response, status: :ok
        NotificationsMailer.edit_alert(@rainwork).deliver
      else
        render json: {status: 'ERROR', message:'Rainwork not updated', data:@rainwork.errors}, status: :unprocessable_entity
      end
    end

    # GET /api/submissions/:id/improve 
    # Endpoint to update edited rainwork thumbnail image and send email notification
    def improve
      @rainwork = Rainwork.find(params.require(:id))

      full_size_image = Dragonfly.app.fetch_url(@rainwork.image_url)
      thumbnail = full_size_image.thumb('300x300#').encode('jpg')
      uid = thumbnail.store(path: "thumbnails/#{@rainwork.id}.jpg")
      @rainwork.thumbnail_url = Dragonfly.app.remote_url_for(uid)

      if @rainwork.save
        NotificationsMailer.edit_alert(@rainwork).deliver
        render json: @rainwork
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    def finalize
      @rainwork = Rainwork.find(params.require(:id))

      if @rainwork.thumbnail_url && !@rainwork.thumbnail_url.empty?
        return render json: { :message => "already has thumbnail" }, status: 400
      end

      full_size_image = Dragonfly.app.fetch_url(@rainwork.image_url)
      thumbnail = full_size_image.thumb('300x300#').encode('jpg')
      uid = thumbnail.store(path: "thumbnails/#{@rainwork.id}.jpg")
      @rainwork.thumbnail_url = Dragonfly.app.remote_url_for(uid)

      if @rainwork
        # NotificationsMailer.submission_alert(@rainwork).deliver
        render json: @rainwork, status: :ok
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
      [:id, :approval_status, :created_at, :installation_date, :creator_name, :creator_email, :description, :lat, :lng, :name, :updated_at, :image_url, :report_count, :found_it_count, :missing_count, :faded_count, :inappropriate_count, :rejection_reason]
    end
  end
end
