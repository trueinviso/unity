class FakeBraintree < WebValve::FakeService
  # # define your routes here
  #
  post "/merchants/:merchant_id/customers" do
    json_response 200, [{ "hi": "hi" }]
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    file_name.to_json
    # File.open(File.dirname(__FILE__) + "/fixtures/" + file_name, "rb").read
  end
  #
  # # set the base url for this API via ENV
  #
  # export BRAINTREE_API_URL='http://whatever.dev'
  #
  # # toggle this service on via ENV
  #
  # export BRAINTREE_ENABLED=true
end
