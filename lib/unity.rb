require "unity/engine"
require_relative "unity/version"
require "haml"
require "braintree"
require "stripe"

module Unity
  extend self

  autoload :BraintreeGateway, "unity/braintree_gateway"
  autoload :Configuration, "unity/configuration"
  autoload :Errors, "unity/errors"
  autoload :StripeGateway, "unity/stripe_gateway"

  mattr_accessor :config

  @@config = Configuration.new

  def configure
    yield config
    configure_stripe if config.stripe?
    configure_braintree if config.braintree?
  end

  def configure_stripe
    Stripe.api_key = config.stripe_secret_key
  end

  def configure_braintree
    BraintreeGateway.configure_braintree(
      environment: config.braintree_environment,
      merchant_id: config.braintree_merchant_id,
      public_key: config.braintree_public_key,
      private_key: config.braintree_private_key,
    )
  end
end
