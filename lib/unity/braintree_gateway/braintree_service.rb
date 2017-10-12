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

      def create_customer(payload)
        ::Braintree::Customer.create(payload)
      end

      def find_customer(gateway_id)
        # TODO: This will probably raise a braintree not found error
        ::Braintree::Customer.find(gateway_id)
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
    end
  end
end
