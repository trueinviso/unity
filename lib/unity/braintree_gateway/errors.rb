module Unity
  module BraintreeGateway
    module Errors
      class NoCustomerPaymentMethodError < StandardError; end
      class ActiveSubscriptionError < StandardError; end
      class NoPlanIdError < StandardError; end
    end
  end
end
