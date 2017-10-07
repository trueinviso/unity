class Unity
  module UnityPlugins
    module BraintreeGateway
      module Actions
        extend self

        def create_customer_subscription(user, params)
          SubscriptionCreator.new(
            user: user,
            params: params,
          ).execute
        end

        def cancel_subscription(subscription)
          SubscriptionCanceller.new(
            subscription,
          ).execute
        end

        def update_subscription(subscription, params)
          SubscriptionUpdater.new(
            subscription: subscription,
            params: params,
          ).execute
        end

        def generate_client_token
          BraintreeService.generate_client_token
        end
      end
    end
  end
end
