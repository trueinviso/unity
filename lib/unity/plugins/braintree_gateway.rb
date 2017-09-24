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
    end

    register_plugin(:braintree_gateway, BraintreeGateway)
  end
end
