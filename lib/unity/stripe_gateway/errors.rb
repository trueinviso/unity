module Unity
  module StripeGateway
    module Errors
      class ActiveSubscriptionError < StandardError; end
      class NoStripePKKeyProvidedError < StandardError; end
      class NullCustomerGatewayIdError < StandardError; end
      class NullPlanIdError < StandardError; end
      class NullSourceError < StandardError; end
      class SubscriptionCreateError < StandardError; end
      class SubscriptionUpdateError < StandardError; end
    end
  end
end
