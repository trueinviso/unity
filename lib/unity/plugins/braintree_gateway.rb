class Unity
  module UnityPlugins
    module BraintreeGateway
      require "unity/plugins/braintree_gateway/errors"
      require "unity/plugins/braintree_gateway/subscription_creator"
      require "unity/plugins/braintree_gateway/customer_creator"
      require "unity/plugins/braintree_gateway/braintree_service"
      require "unity/plugins/braintree_gateway/configuration"
      require "unity/plugins/braintree_gateway/create_subscription_payload"
      require "unity/plugins/braintree_gateway/subscription_canceller"
      require "unity/plugins/braintree_gateway/actions"

      module ClassMethods
        def create_braintree_subscription(user, params)
          Actions.create_customer_subscription(user, params)
        end

        def cancel_braintree_subscription(subscription)
          Actions.cancel_subscription(subscription)
        end

        def generate_braintree_token
          Actions.generate_client_token
        end

        # Convenience method to set braintree configurations.
        def configure_braintree(environment:, merchant_id:, public_key:, private_key:)
          raise UnityError, "Plugin `braintree_gateway` did not register itself correclty in Unity::UnityPlugins" unless plugins[:braintree_gateway]
          Configuration.environment = environment
          Configuration.merchant_id = merchant_id
          Configuration.public_key = public_key
          Configuration.private_key = private_key
        end

      end
    end

    register_plugin(:braintree_gateway, BraintreeGateway)
  end
end
