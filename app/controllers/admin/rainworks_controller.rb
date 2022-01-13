module Admin
  class RainworksController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions

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
      token = rainwork.device&.push_token&.data
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
