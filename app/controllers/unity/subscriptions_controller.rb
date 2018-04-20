module Unity
  class SubscriptionsController < ApplicationController
    before_action :set_subscription, only: [:update]

    def new
      @token = BraintreeGateway::Actions.generate_client_token
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

    def update
      result = update_subscription

      if result.success?
        redirect_to [:new, :subscription]
        # redirect_to main_app.root_path
      else
        redirect_to action: "edit"
      end
    end

    def destroy
      result = cancel_subscription

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

    def update_params
      params.permit(:plan_id)
    end

    def set_subscription
      @subscription ||= Subscription.where(user_id: current_user.id).first
    end

    def create_subscription
      validate_user
      BraintreeGateway::Actions.create_customer_subscription(
        current_user,
        create_params,
      )
    end

    def validate_user
      raise Errors::NoCurrentUserProvided if current_user.blank?
      if !current_user.has_attribute?(:gateway_customer_id)
        raise Errors::NoGatewayCustomerIdOnUserModel
      end
    end

    def update_subscription
      BraintreeGateway::Actions.update_subscription(
        @subscription,
        update_params,
      )
    end

    def cancel_subscription
      BraintreeGateway::Actions.cancel_subscription(
        Subscription.find_by(user_id: current_user.id),
      )
    end

  end
end
