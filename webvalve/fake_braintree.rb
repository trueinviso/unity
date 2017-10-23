class FakeBraintree < WebValve::FakeService
  # # define your routes here
  #
  post "/merchants/:merchant_id/customers" do
    gzip_response(
      200,
      Braintree::Xml.hash_to_xml(response_class(:customer).build)
    )
  end

  get "/merchants/:merchant_id/customers/:id" do
    gzip_response(
      200,
      Braintree::Xml.hash_to_xml(response_class(:customer).build)
    )
  end

  post "/merchants/:merchant_id/subscriptions" do
    gzip_response(
      200,
      Braintree::Xml.hash_to_xml(
        response_class(:subscription).build,
      )
    )
  end

  get "/merchants/:merchant_id/subscriptions/:id" do
    gzip_response(
      200,
      Braintree::Xml.hash_to_xml(
        response_class(:subscription).build,
      )
    )
  end

  private

  def response_class(key)
    Object.const_get(FakeBraintree.response_class[key])
  end

  # def parse_params(xml)
  #   Nokogiri::XML(xml)
  #     .root
  #     .element_children
  #     .each_with_object(Hash.new) do |e,h|
  #       h[e.name.to_sym] = e.content
  #     end
  # end

  def gzip_response(response_code, xml)
    status response_code
    headers["Content-Encoding"] = "gzip"
    StringIO.new.tap do |io|
      gz = Zlib::GzipWriter.new(io)
      begin
        gz.write(xml)
      ensure
        gz.close
      end
    end.string
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
