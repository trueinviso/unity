module Unity
  module BraintreeGateway
    class SwapBillingCycle
      attr_reader :swap_builder

      def self.for(swap_builder)
        new(swap_builder).swap
      end

      def initialize(swap_builder)
        @swap_builder = swap_builder
      end

      private

      def swap
        discount_payload = build_discount_payload
        result = cancel_current_subscription
        result = create_subscription if result.success?
        result
      end

      def build_discount_payload
        GetSwapDiscountPayload.new(swap_builder).build
      end

      def cancel_current_subscription
        SubscriptionCanceller.new(bt_subscription).execute
      end

      def create_subscription(discount_payload)
        SubscriptionCreator.new(
          user: swap_builder.user,
          params: swap_builder.params,
          discount_payload: discount_payload,
        ).execute
      end
    end
  end
end
