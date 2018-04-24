module Unity
  class PaymentMethodController < ApplicationController
    before_action :verify_subscription, only: [:edit, :update]

    def edit
      @token = BraintreeGateway::Actions.generate_client_token
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

    def update_customer
      BraintreeGateway::Actions
        .update_customer(current_user, update_args)
    end

    def verify_subscription
      Subscription
        .find_by(id: current_user.id)
        &.previously_subscribed?
    end
  end
end
