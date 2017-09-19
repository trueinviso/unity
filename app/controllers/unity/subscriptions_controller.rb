module Unity
  class SubscriptionsController < ApplicationController
    def new
      @braintree_token = GatewayActions.generate_client_token
    end

    def edit
    end

    def create
      result = create_subscription

      if result.success?
        redirect_to [:root]
      else
        redirect_to action: "new"
      end
    end

    def destroy
      result = Unity::GatewayActions.cancel_subscription(
        Unity::Subscription.find_by(user_id: current_user.id)
      )

      if result.success?
        redirect_to [:root]
      else
        redirect_to action: "edit"
      end
    end

    private

    def create_params
      params.permit(:payment_method_nonce, :plan_id)
    end

    def create_subscription
      # TODO: raise error if host app doesn't provide current_user
      # need to add gateway_customer_id to user model in host app
      Unity::GatewayActions.create_customer_subscription(
        user: current_user,
        params: create_params,
      ).execute
    end
  end
end
