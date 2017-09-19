module Unity
  module BraintreeGateway
    require "unity/braintree_gateway/errors"
    autoload :SubscriptionCreator, "unity/braintree_gateway/subscription_creator"
    autoload :CustomerCreator, "unity/braintree_gateway/customer_creator"
    autoload :BraintreeService, "unity/braintree_gateway/braintree_service"
    autoload :Configuration, "unity/braintree_gateway/configuration"
    autoload :CreateSubscriptionPayload, "unity/braintree_gateway/create_subscription_payload"
    autoload :SubscriptionCanceller, "unity/braintree_gateway/subscription_canceller"
  end
end
