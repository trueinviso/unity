module Unity
  module BraintreeGateway
    module Actions
      extend self

      def create_customer_subscription(user, params)
        SubscriptionCreator.new(
          user: user,
          params: params,
        ).execute
      end

      def cancel_subscription(subscription)
        SubscriptionCanceller.new(
          subscription,
        ).execute
      end

      def update_subscription(subscription, params)
        SubscriptionUpdater.new(
          subscription: subscription,
          params: params,
        ).execute
      end

      def update_customer(user, params)
        CustomerUpdater.update!(user, params)
      end

      def generate_client_token
        BraintreeService.generate_client_token
      end
    end
  end
end
