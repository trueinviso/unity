module Unity
  module GatewayActions
    extend self

    def create_customer_subscription(user, params)
      BraintreeGateway::SubscriptionCreator.new(
        user, params
      ).execute
    end

    def cancel_subscription(subscription)
      BraintreeGateway::SubscriptionCanceller.new(
        subscription
      ).execute
    end

    def generate_client_token
      BraintreeGateway::BraintreeService.generate_client_token
    end
  end
end
