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
        create_local_payment_method
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
          customer: gateway_customer.gateway_id,
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
          gateway_id: result.id,
          gateway_status: result.status,
          gateway_type: :stripe,
          subscription_plan: subscription_plan,
        )
      end

      def create_local_payment_method
        payment_method = PaymentMethod
          .find_or_initialize_by(user: user)

        payment_method.update!(
          gateway_id: stripe_customer.default_source,
          gateway_type: :stripe,
        )
      end

      def stripe_customer
        @stripe_customer ||= Stripe::Customer
          .retrieve(gateway_customer.gateway_id)
      end

      def subscription_plan
        SubscriptionPlan.find_by!(
          gateway_id: params.fetch(:plan_id),
        )
      end

      def gateway_customer
        @gateway_customer ||= GatewayCustomer.find_by(user: user)
      end

      def validate_arguments!(user, params)
        raise Errors::NullCustomerGatewayIdError unless gateway_customer.gateway_id.present?
        raise Errors::NullPlanIdError unless params.fetch(:plan_id).present?
        unless params.fetch(:payment_method_nonce).present?
          raise Errors::NullSourceError
        end
      end
    end
  end
end
