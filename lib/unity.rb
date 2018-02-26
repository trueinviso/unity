require "unity/engine"
require_relative "unity/version"
require "haml"
require "braintree"

module Unity
  autoload :BraintreeGateway, "unity/braintree_gateway"

  mattr_accessor :user_class, :allow_multiple_subscriptions
  @@user_class = "User"
  @@allow_multiple_subscriptions = false
end
