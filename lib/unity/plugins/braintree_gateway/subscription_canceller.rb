class Unity
  module UnityPlugins
    module BraintreeGateway
      class SubscriptionCanceller
        attr_reader :subscription
        attr_reader :braintree_service

        # set it to last billing cycle
        # make braintree hook that lets you know when it cancels
        # if they reactivate before it's fully cancelled, just set
        # back to never ends
        def initialize(subscription, braintree_service: BraintreeService)
          @subscription = subscription
          @braintree_service = braintree_service
        end

        def execute
          cancel_subscription
        end

        private

        def cancel_subscription
          braintree_service.update_subscription(
            subscription.gateway_id, cancel_payload
          )
        end

        # Set subscription to finish at end of billing cycle
        # Use braintree hook to set local subscription
        # status to cancelled when subscription ends
        def cancel_payload
          {
            number_of_billing_cycles: 1
          }
        end
      end
    end
  end
end
