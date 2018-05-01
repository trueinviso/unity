module Unity
  module BraintreeGateway
    module BraintreeService
      extend self

      def create_subscription(payload)
        ::Braintree::Subscription.create(payload)
      end

      def update_subscription(gateway_id, payload)
        ::Braintree::Subscription.update(gateway_id, payload)
      end

      def begin_trial(user)
        if Subscription.find_by(user_id: user.id)&.previously_subscribed?
          raise ActiveBraintreeSubscriptionError
        end
        subscription = Subscription.where(user: user).first_or_initialize

        subscription.update!(
          user: user,
          trial_ends_at: 1.week.from_now,
          subscription_plan: SubscriptionPlan.find_by(name: "trial"),
        )
        subscription.reload
      end

      def create_customer(payload)
        ::Braintree::Customer.create(payload)
      end

      def find_customer(gateway_id)
        # TODO: This will probably raise a braintree not found error
        result = ::Braintree::Customer.find(gateway_id)
        result.define_singleton_method(:success?) { true }
        result.define_singleton_method(:customer) { self }
        result
      end

      def update_customer(user, payload)
        gateway_id = gateway_customer(user).gateway_id
        ::Braintree::Customer.update(gateway_id, payload)
      end

      def cancel_subscription(gateway_id)
        ::Braintree::Subscription.cancel(gateway_id)
      end

      def find_subscription(gateway_id)
        ::Braintree::Subscription.find(gateway_id)
      end

      def braintree_plans
        ::Braintree::Plan.all
      end

      def generate_client_token
        ::Braintree::ClientToken.generate(
          merchant_account_id: Configuration.merchant_id
        )
      end

      private

      def gateway_customer(user)
        @gateway_customer ||= GatewayCustomer.find_by(user: user)
      end
    end
  end
end
