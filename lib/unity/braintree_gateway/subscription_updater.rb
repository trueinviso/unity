module Unity
  module BraintreeGateway
    class SubscriptionUpdater
      attr_reader :bt_subscription
      attr_reader :subscription
      attr_reader :params
      attr_reader :user
      attr_reader :braintree_service
      attr_reader :current_plan_id

      def initialize(subscription:, params:, braintree_service: BraintreeService)
        @user = subscription.user
        @braintree_service = braintree_service
        @subscription = subscription
        @bt_subscription = find_braintree_subscription(subscription)
        @current_plan_id = subscription.subscription_plan.gateway_id
        @params = params
      end

      def execute
        update
      end

      private

      def update
        if canceled?
          create_subscription
        elsif changing_billing_cycle?
          swap_billing_cycle
        else
          update_subscription
        end
      end

      def canceled?
        bt_subscription.status == "Canceled"
      end

      # TODO: Any problems with using find_or_create_customer in creator?
      def create_subscription
        SubscriptionCreator.new(
          user: user,
          params: params,
        ).execute
      end

      def changing_billing_cycle?
        current_plan.billing_frequency != new_plan.billing_frequency
      end

      def swap_billing_cycle
        SwapBillingCycle.for(swap_builder)
      end

      SwapBuilder = Struct.new(:bt_subscription, :subscription, :user, :params, :new_plan, :current_plan)

      def swap_builder
        SwapBuilder.new(
          bt_subscription,
          subscription,
          user,
          params,
          new_plan,
          current_plan,
        )
      end

      def new_plan
        @new_plan ||= Plan.plan_by_id(params[:plan_id])
      end

      def current_plan
        @current_plan ||= Plan.plan_by_id(current_plan_id)
      end

      def update_subscription
        result = braintree_update
        update_local_subscription(result) if result.success?
        result
      end

      def braintree_update
        braintree_service.update_subscription(
          bt_subscription.id,
          update_payload,
        )
      end

      def update_local_subscription(result)
        local_plan = SubscriptionPlan.find_by(gateway_id: result.subscription.plan_id)
        subscription.subscription_plan = local_plan
        subscription.save!
      end

      def update_payload
        UpdateSubscriptionPayload.build(
          bt_subscription,
          params,
        )
      end

      def bt_customer
        braintree_service.find_customer(gateway_customer.gateway_id)
      end

      def gateway_customer(user)
        @gateway_customer ||= GatewayCustomer.find_by(user: user)
      end

      def find_braintree_subscription(subscription)
        braintree_service.find_subscription(subscription.gateway_id)
      end
    end
  end
end
