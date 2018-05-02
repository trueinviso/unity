module Unity
  module StripeGateway
    class SubscriptionUpdater
      attr_reader :subscription, :params

      def initialize(subscription, params)
        @subscription = subscription
        @params = params
      end

      def self.call!(subscription, params)
        new(subscription, params).update
      end

      def update
        validate_arguments!
        result = update_stripe_subscription
        result = Result.new(result)
        raise Errors::SubscriptionUpdateError unless result.success?
        update_local_subscription(result.result)
        result
      end

      private

      Result = Struct.new(:result) do
        def success?
          result.is_a?(Stripe::Subscription)
        end
      end

      def update_stripe_subscription
        gateway_subscription = Stripe::Subscription
          .retrieve(subscription.gateway_id)
        gateway_subscription.cancel_at_period_end = false
        gateway_subscription.items = [{
          id: gateway_subscription.items.data[0].id,
          plan: params.fetch(:plan_id),
        }]
        gateway_subscription.save
      end

      def update_local_subscription(result)
        subscription.update!(
          cancellation_date: nil,
          gateway_type: :stripe,
          marked_for_cancellation_at: nil,
          gateway_status: result.status,
          subscription_plan: subscription_plan,
        )
      end

      def subscription_plan
        SubscriptionPlan.find_by!(
          gateway_id: params.fetch(:plan_id),
        )
      end

      def validate_arguments!
        raise Errors::NullPlanIdError unless params[:plan_id].present?
      end
    end
  end
end
