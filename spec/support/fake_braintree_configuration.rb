require "rails_helper"

module FakeBraintreeConfiguration
  def configure_fake_braintree_response(response_hash)
    FakeBraintree.response_class = response_hash
  end
end

RSpec.configure do |config|
  config.include FakeBraintreeConfiguration
end
