# # register services
#
# WebValve.register FakeThing
# WebValve.register FakeExample, url: 'https://api.example.org'
#
# # whitelist urls
#
# WebValve.whitelist_url 'https://example.com'
WebValve.register FakeBraintree, url: ENV.fetch("BRAINTREE_API_URL")
