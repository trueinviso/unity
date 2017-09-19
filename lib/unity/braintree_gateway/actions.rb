module Unity
  module BraintreeGateway
    module Actions
      extend self

      def create_customer_subscription(user, params)
        SubscriptionCreator.new(user, params).execute
      end
    end
  end
end
