module Unity
  module StripeGateway
    module Actions
      extend self

      def create_customer_subscription(user, params)
        SubscriptionCreator.create!(user, params)
      end

      def create_customer(user)
        CustomerCreator.call!(user)
      end

      def cancel_subscription(subscription)
        SubscriptionCanceller.call!(subscription)
      end

      def update_subscription(subscription, params)
        SubscriptionUpdater.call!(subscription, params)
      end

      def update_customer(user, params)
        CustomerUpdater.update!(user, params)
      end
    end
  end
end
