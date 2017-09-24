class Unity
  module UnityPlugins
    module BraintreeGateway
      module Errors
        class NoCustomerPaymentMethodError < StandardError; end
        class ActiveSubscriptionError < StandardError; end
      end
    end
  end
end
