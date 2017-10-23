# require "rails_helper"
module BraintreeHelper
  def configure_braintree
    Unity::BraintreeGateway.configure_braintree(
      environment: ENV["BT_ENVIRONMENT"],
      merchant_id: ENV["BT_MERCHANT_ID"],
      public_key: ENV["BT_PUBLIC_KEY"],
      private_key: ENV["BT_PRIVATE_KEY"],
    )
  end
end

RSpec.configure do |config|
  config.include BraintreeHelper
end
