module Unity
  module BraintreeGateway
    class SubscriptionUpdater
      attr_reader :bt_subscription
      attr_reader :params
      attr_reader :user
      attr_reader :braintree_service
      attr_reader :current_plan_id

      def initialize(subscription:, params:, braintree_service: BraintreeService)
        @user = subscription.user
        @braintree_service = braintree_service
        @bt_subscription = find_braintree_subscription(subscription)
        @current_plan_id = subscription.subscription_plan.gateway_id
        @params = params
      end

      def execute
        update
      end

      private

      def update
        if bt_subscription.status == "Canceled"
          create_subscription
        elsif changing_billing_cycle?
          swap_billing_cycle
        else
          update_subscription
        end
      end

      def create_subscription
        braintree_service.create_subscription(create_payload)
      end

      def changing_billing_cycle?
        current_plan.billing_frequency != new_plan.billing_frequency
      end

      def new_plan
        Plan.plan_by_id(params[:plan_id])
      end

      def current_plan
        Plan.plan_by_id(current_plan_id)
      end

      def swap_billing_cycle
        SwapBillingCycle.for(subscription, params)
      end

      def update_subscription
        braintree_service.update_subscription(
          bt_subscription.id,
          update_payload,
        )
      end

      def update_payload
        UpdateSubscriptionPayload.build(
          bt_subscription,
          params,
        )
      end

      def create_payload
        CreateSubscriptionPayload.new(
          user,
          params,
          bt_customer: bt_customer,
        )
      end

      def bt_customer
        braintree_service.find_customer(user.gateway_customer_id)
      end

      def find_braintree_subscription(subscription)
        braintree_service.find_subscription(subscription.gateway_id)
      end
    end
  end
end
