require "unity/engine"
require_relative "unity/version"
require "haml"
require "braintree"

module Unity
  autoload :BraintreeGateway, "unity/braintree_gateway"

  mattr_accessor :user_class
  @@user_class = "User"
end
