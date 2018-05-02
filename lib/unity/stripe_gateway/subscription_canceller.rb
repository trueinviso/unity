module Unity
  module StripeGateway
    class SubscriptionCanceller
      attr_reader :subscription

      def initialize(subscription)
        @subscription = subscription
      end

      def self.call!(subscription)
        new(subscription).cancel
      end

      def cancel
        result = cancel_stripe_subscription
        result = Result.new(result)
        raise Errors::SubscriptionCancelError unless result.success?
        update_local_subscription(result.result)
        result
      end

      private

      Result = Struct.new(:result) do
        def success?
          result.is_a?(Stripe::Subscription)
        end
      end

      def update_local_subscription(result)
        subscription.update!(
          cancellation_date: Time.at(result.current_period_end),
          marked_for_cancellation_at: Time.current,
        )
      end

      def cancel_stripe_subscription
        gateway_subscription = Stripe::Subscription
          .retrieve(subscription.gateway_id)
        gateway_subscription.delete(at_period_end: true)
      end
    end
  end
end
