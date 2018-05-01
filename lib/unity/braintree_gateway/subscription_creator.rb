module Unity
  module BraintreeGateway
    class SubscriptionCreator
      attr_reader :braintree_service
      attr_reader :bt_customer
      attr_reader :customer_strategy
      attr_reader :discount_payload
      attr_reader :params
      attr_reader :user

      def initialize(user:, params:, discount_payload: {}, braintree_service: BraintreeService)
        @braintree_service = braintree_service
        @customer_strategy = CustomerCreator.new(user: user, params: params)
        @discount_payload = discount_payload
        @params = params
        @user = user
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
        CreateSubscriptionPayload.new(
          bt_customer: bt_customer,
          discount_payload: discount_payload,
          params: params,
        ).build
      end

      def create_local_subscription(result)
        local_subscription = Subscription
          .find_or_initialize_by(user: user)

        local_subscription.update!(
          gateway_id: result.subscription.id,
          gateway_status: result.subscription.status.downcase.to_sym,
          gateway_type: :braintree,
          subscription_plan_id: desired_plan.id,
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
