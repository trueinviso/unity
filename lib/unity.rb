require "unity/engine"
require_relative "unity/version"
require "haml"
require "braintree"

module Unity
  autoload :BraintreeGateway, "unity/braintree_gateway"
  autoload :Errors, "unity/errors"

  mattr_accessor :user_class,
    :allow_multiple_subscriptions,
    :hosted_fields,
    :gateway_type

  @@user_class = "User"
  @@allow_multiple_subscriptions = false
  @@hosted_fields = true
  @@gateway_type = "braintree"
end
