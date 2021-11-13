require 'exponent-server-sdk'

module Admin
  class RainworksController < Admin::ApplicationController
    before_action :default_params

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    
    def default_params
      params[:order] ||= "created_at"
    end

    def approve
      @rainwork = Rainwork.find(params[:id])

      @rainwork.approval_status = :accepted

      if @rainwork.save
        send_notification(@rainwork, 'Your rainwork submission was accepted.', :accepted);

        flash[:accepted] = 'Rainwork was accepted'
        redirect_to url_for(action: :show)
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    def reject
      @rainwork = Rainwork.find(params[:id])

      @rainwork.approval_status = :rejected

      if params[:rejection_reason]
        @rainwork.rejection_reason = params[:rejection_reason]

        if @rainwork.save
          send_notification(@rainwork, 'Your rainwork submission was rejected.', :rejected);
        end

        flash[:rejected] = 'Rainwork was rejected'
        redirect_to url_for(action: :show)
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    def expire
      @rainwork = Rainwork.find(params[:id])

      @rainwork.approval_status = :expired

      if @rainwork.save
        send_notification(@rainwork, 'Your rainwork has expired.', :expired);

        flash[:expired] = 'Rainwork was expired'
        redirect_to url_for(action: :show)
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    private
    def exponent
      @exponent ||= Exponent::Push::Client.new
    end

    def send_notification(rainwork, body, notification_type)
      token = rainwork.device&.push_token
      if token and Exponent::is_exponent_push_token?(token)
        message = {
          to: token,
          body: body,
          data: { rainwork_id: rainwork.id, notification_type: notification_type }, # Any arbitrary data to include with the notification
        }
        result = exponent.publish [message]
        puts result
      end
    end
  end
end
