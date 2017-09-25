module Unity
  class SubscriptionsController < ApplicationController
    def new
      byebug
      @token = Unity.generate_braintree_token
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
      result = Unity.cancel_braintree_subscription(
        Subscription.find_by(user_id: current_user.id)
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
      Unity.create_braintree_subscription(
        user: current_user,
        params: create_params,
      )
    end
  end
end
