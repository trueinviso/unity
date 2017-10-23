# # register services
#
# WebValve.register FakeThing
# WebValve.register FakeExample, url: 'https://api.example.org'
#
# # whitelist urls
#
# WebValve.whitelist_url 'https://example.com'
#
# Enable deterministic tests
FakeBraintree.class_eval %Q{
  def self.response_class=(val)
    @response_class = val
  end

  def self.response_class
    @response_class
  end
}
WebValve.register FakeBraintree, url: "https://api.sandbox.braintreegateway.com"
