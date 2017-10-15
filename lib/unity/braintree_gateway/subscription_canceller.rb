module Unity
  module BraintreeGateway
    class SubscriptionCanceller
      attr_reader :subscription
      attr_reader :braintree_service
      attr_reader :cancel_now

      def initialize(subscription, cancel_now: false, braintree_service: BraintreeService)
        @subscription = subscription
        @cancel_now = cancel_now
        @braintree_service = braintree_service
      end

      def execute
        cancel_subscription
      end

      private

      def cancel_subscription
        if cancel_now
          cancel
        else
          cancel_at_end_of_billing_cycle
        end
      end

      def cancel
        # TODO: verify not cancelled
        result = braintree_service.cancel_subscription(subscription.gateway_id)
        cancel_local_subscription if result.success?
        result
      end

      def cancel_local_subscription
        subscription.update!(gateway_status: "Canceled")
      end

      # Set subscription to finish at end of billing cycle
      # Use braintree hook to set local subscription
      # status to cancelled when subscription ends
      # TODO: What if subscription is past due
      def cancel_at_end_of_billing_cycle
        braintree_service.update_subscription(
          subscription.gateway_id, cancel_payload
        )
      end

      def cancel_payload
        {
          number_of_billing_cycles: 1
        }
      end
    end
  end
end
