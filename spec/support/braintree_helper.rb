# require "rails_helper"
module BraintreeHelper
  def configure_braintree
    Unity::BraintreeGateway.configure_braintree(
      environment: ENV["BRAINTREE_ENVIRONMENT"],
      merchant_id: ENV["BRAINTREE_MERCHANT_ID"],
      public_key: ENV["BRAINTREE_PUBLIC_KEY"],
      private_key: ENV["BRAINTREE_PRIVATE_KEY"],
    )
  end
end

RSpec.configure do |config|
  config.include BraintreeHelper
end
