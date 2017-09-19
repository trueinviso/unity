require "unity/engine"
require "haml"
require "braintree"

module Unity
  autoload :BraintreeGateway, "unity/braintree_gateway"
  autoload :GatewayActions, "unity/gateway_actions"
  # Subscription belongs to user by default unless otherwise specified
  mattr_accessor :user_class
  @@user_class = "User"
end