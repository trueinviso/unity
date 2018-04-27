module Unity
  class PaymentMethodController < ApplicationController
    before_action :set_subscription, only: [:edit, :update]
    before_action :verify_subscription, only: [:edit, :update]

    def edit
      @token = Unity.config.client_token
    end

    def update
      result = update_customer
      if result.success?
        flash[:notice] = "You have successfully updated your credit card."
      else
        message = "Uh oh. Looks like something went wrong. Please try again."
        flash[:error] = message
      end
      redirect_to [:edit, :payment_method]
    end

    private

    def update_args
      params.permit(
        :address,
        :billing_zip,
        :city,
        :first_name,
        :last_name,
        :payment_method_nonce,
        :phone,
        :state,
      )
    end

    def gateway
      Object.const_get(
        "Unity::#{@subscription.gateway_type.capitalize}Gateway"
      )
    end

    def update_customer
      gateway::Actions
        .update_customer(current_user, update_args)
    end

    def verify_subscription
      @subscription&.previously_subscribed?
    end

    def set_subscription
      @subscription ||= Subscription
        .find_by(user_id: current_user.id)
    end
  end
end
