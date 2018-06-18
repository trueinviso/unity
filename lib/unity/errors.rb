module Unity
  module Errors
    class NoCurrentUserProvided < StandardError; end
    class NoUserProvided < StandardError; end
    # fix tests
    class NoGatewayCustomerId < StandardError; end
  end
end
