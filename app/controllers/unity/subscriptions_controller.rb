module Unity
  class SubscriptionsController < ApplicationController
    def new
      @braintree_token = BraintreeGateway::BraintreeService.generate_client_token
    end

    def create
      result = create_subscription

      if result.success?
        redirect_to [:root]
      else
        redirect_to action: "new"
      end
    end

    private

    def create_params
      params.permit(:payment_method_nonce, :plan_id)
    end

    def create_subscription
      # TODO: raise error if host app doesn't provide current_user
      # need to add gateway_customer_id to user model in host app
      BraintreeGateway::SubscriptionCreator.new(
        user: current_user,
        params: create_params,
      ).execute
    end
  end
end
