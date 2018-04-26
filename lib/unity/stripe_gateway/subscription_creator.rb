module Unity
  module StripeGateway
    class SubscriptionCreator
      attr_reader :user, :params

      def initialize(user, params)
        @user = user
        @params = params
      end

      def self.create!(user, params)
        new(user, params).create
      end

      def create
        validate_arguments!(user, params)
        result = create_stripe_subscription
        result = Result.new(result)
        raise Errors::SubscriptionCreateError unless result.success?
        create_local_subscription(result.result)
        result
      end

      private

      Result = Struct.new(:result) do
        def success?
          result.is_a?(Stripe::Subscription)
        end
      end

      def create_stripe_subscription
        Stripe::Subscription.create(
          customer: user.gateway_customer_id,
          source: params.fetch(:payment_method_nonce),
          items: [
            plan: params.fetch(:plan_id),
          ]
        )
      end

      def create_local_subscription(result)
        subscription = Subscription
          .find_or_initialize_by(user: user)

        subscription.update!(
          subscription_plan: subscription_plan,
          gateway_id: result.id,
          gateway_status: result.status,
          gateway_type: params.fetch(:gateway_type),
        )
      end

      def subscription_plan
        SubscriptionPlan.find_by!(
          gateway_id: params.fetch(:plan_id),
        )
      end

      def validate_arguments!(user, params)
        raise Errors::NullCustomerGatewayIdError unless user.gateway_customer_id.present?
        raise Errors::NullPlanIdError unless params.fetch(:plan_id).present?
        unless params.fetch(:payment_method_nonce).present?
          raise Errors::NullSourceError
        end
      end
    end
  end
end
