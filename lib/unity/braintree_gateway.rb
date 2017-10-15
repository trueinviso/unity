module Unity
  module BraintreeGateway
    extend self

    require "unity/braintree_gateway/errors"
    autoload :SubscriptionCreator,"unity/braintree_gateway/subscription_creator"
    autoload :CustomerCreator,"unity/braintree_gateway/customer_creator"
    autoload :BraintreeService,"unity/braintree_gateway/braintree_service"
    autoload :Configuration,"unity/braintree_gateway/configuration"
    autoload :CreateSubscriptionPayload,"unity/braintree_gateway/create_subscription_payload"
    autoload :SubscriptionCanceller,"unity/braintree_gateway/subscription_canceller"
    autoload :SubscriptionUpdater,"unity/braintree_gateway/subscription_updater"
    autoload :UpdateSubscriptionPayload,"unity/braintree_gateway/update_subscription_payload"
    autoload :DiscountHashBuilder,"unity/braintree_gateway/discount_hash_builder"
    autoload :GetSwapDiscountPayload,"unity/braintree_gateway/get_swap_discount_payload"
    autoload :SwapBillingCycle,"unity/braintree_gateway/swap_billing_cycle"
    autoload :Plan,"unity/braintree_gateway/plan"
    autoload :Actions,"unity/braintree_gateway/actions"

    # Convenience method to set braintree configurations.
    def configure_braintree(environment:, merchant_id:, public_key:, private_key:)
      Configuration.environment = environment
      Configuration.merchant_id = merchant_id
      Configuration.public_key = public_key
      Configuration.private_key = private_key
    end
  end
end
