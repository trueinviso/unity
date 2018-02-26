module Unity
  module BraintreeGateway
    class CreateSubscriptionPayload
      attr_reader :user
      attr_reader :bt_customer
      attr_reader :params
      attr_reader :discount_payload
      attr_reader :braintree_service

      def initialize(
        params:,
        bt_customer:,
        discount_payload: { discounts: {} },
        braintree_service: BraintreeService
      )
        @params = params
        @bt_customer = bt_customer
        @discount_payload = discount_payload
        @braintree_service = braintree_service
      end

      def build
        if !Unity.allow_multiple_subscriptions
          assert_customer_does_not_already_have_active_subscription
        end
        payload.merge!(discount_payload)
      end

      private

      def payload
        {
          payment_method_token: default_payment_method_token,
          plan_id: params[:plan_id],
        }
      end

      def default_payment_method_token
        # TODO: Use user payment method token here
        unless bt_customer.payment_methods.any?
          raise Errors::NoCustomerPaymentMethodError
        end
        bt_customer.default_payment_method.token
      end

      def active_subscription?
        bt_customer.credit_cards
          .map(&:subscriptions).flatten
          .map(&:status)
          .include?('Active')
      end

      def assert_customer_does_not_already_have_active_subscription
        if active_subscription?
          raise Errors::ActiveSubscriptionError
        end
      end
    end
  end
end
