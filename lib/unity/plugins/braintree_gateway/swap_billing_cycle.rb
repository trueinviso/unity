module UnityPlugins
  module BraintreeGateway
    class SwapBillingCycle
      attr_reader :subscription, :params

      def self.for(subscription:, params:,)
        new(subscription, params).swap
      end

      def initialize(subscription, params)
        @subscription = subscription
        @params = params
      end

      private

      def swap
        build_swap_discount
        cancel_current_subscription
        create_subscription
      end

      def build_swap_discount
      end

      def cancel_current_subscription
      end

      def create_subscription
      end
    end
  end
end
