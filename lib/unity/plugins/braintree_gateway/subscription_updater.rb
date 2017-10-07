module UnityPlugins
  module BraintreeGateway
    class SubscriptionUpdater
      attr_reader :subscription, :params, :braintree_service

      def initialize(subscription:, params:, braintree_service: BraintreeService)
        @subscription = subscription
        @params = params
        @braintree_service = braintree_service
      end

      def execute
        update
      end

      private

      def update
        if subscription.cancelled?
          create_subscription
        elsif changing_billing_cycle?
          swap_billing_cycle
        else
          update_subscription
        end
      end

      def create_subscription
      end

      def changing_billing_cycle?
      end

      def swap_billing_cycle
        SwapBillingCycle.for(subscription, params)
      end

      def update_subscription
      end
    end
  end
end
