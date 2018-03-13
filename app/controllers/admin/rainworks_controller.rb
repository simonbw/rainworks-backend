module Admin
  class RainworksController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Rainwork.
    #     page(params[:page]).
    #     per(10)
    # end
    #
    #

    def approve
      @rainwork = Rainwork.find(params[:id])

      @rainwork.approval_status = :accepted

      if @rainwork.save
        # TODO: send notification
        
        flash[:accepted] = 'Rainwork was accepted'
        redirect_to url_for(action: :show)
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    def reject
      @rainwork = Rainwork.find(params[:id])

      @rainwork.approval_status = :rejected

      if @rainwork.save
        # TODO: send notification
        
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
        # TODO: send notification
        
        flash[:expired] = 'Rainwork was expired'
        redirect_to url_for(action: :show)
      else
        render json: @rainwork.errors, status: :unprocessable_entity
      end
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Rainwork.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
