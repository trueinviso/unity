require "unity/engine"
require_relative "unity/version"
require "haml"
require "braintree"

module Unity
  autoload :BraintreeGateway, "unity/braintree_gateway"

  mattr_accessor :user_class,
    :allow_multiple_subscriptions,
    :hosted_fields

  @@user_class = "User"
  @@allow_multiple_subscriptions = false
  @@hosted_fields = true
end
