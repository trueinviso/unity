module Unity
  module StripeGateway
    extend self

    require "unity/stripe_gateway/errors"
    autoload :Actions,"unity/stripe_gateway/actions"
    autoload :CustomerCreator,"unity/stripe_gateway/customer_creator"
    autoload :CustomerUpdater,"unity/stripe_gateway/customer_updater"
    autoload :SubscriptionCanceller,"unity/stripe_gateway/subscription_canceller"
    autoload :SubscriptionCreator,"unity/stripe_gateway/subscription_creator"
    autoload :SubscriptionUpdater,"unity/stripe_gateway/subscription_updater"
  end
end
