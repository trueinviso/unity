module Unity
  module Errors
    class NoCurrentUserProvided < StandardError; end
    class NoUserProvided < StandardError; end
    class NoGatewayCustomerIdOnUserModel < StandardError; end
  end
end
