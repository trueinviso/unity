module Unity
  module BraintreeGateway
    class SubscriptionCreator
      attr_reader :user, :params, :braintree_service, :customer_strategy
      attr_reader :params
      attr_reader :braintree_service
      attr_reader :customer_strategy
      attr_reader :bt_customer

      def initialize(user:, params:, braintree_service: BraintreeService)
        @user = user
        @params = params
        @braintree_service = braintree_service
        @customer_strategy = CustomerCreator.new(user: user, params: params)
      end

      def execute
        create_customer_subscription
      end

      private

      def create_customer_subscription
        customer_result = customer_strategy.find_or_create_customer
        subscription_result = nil
        if customer_result.success?
          @bt_customer = customer_result.customer
          subscription_result = create_subscription
        end
        subscription_result || customer_result
      end

      def create_subscription
        result = braintree_service.create_subscription(
          build_create_subscription_payload
        )
        create_local_subscription(result) if result.success?
        result
      end

      def build_create_subscription_payload
        Unity::BraintreeGateway::CreateSubscriptionPayload.new(
          user, params, bt_customer: bt_customer
        ).build
      end

      def create_local_subscription(result)
        subscription = Subscription.create!(
          gateway_id: result.subscription.id,
          gateway_status: result.subscription.status.downcase,
          subscription_plan_id: desired_plan.id,
          user_id: user.id,
        )
      end

      def desired_plan
        @desired_plan ||= Unity::SubscriptionPlan.find_by(
          gateway_id: params[:plan_id]
        )
      end
    end
  end
end
