class Unity
  module UnityPlugins
    module BraintreeGateway
      class CreateSubscriptionPayload
        attr_reader :user
        attr_reader :bt_customer
        attr_reader :params
        attr_reader :braintree_service

        def initialize(user, params, bt_customer:, braintree_service: BraintreeService)
          @params = params
          @user = user
          @bt_customer = bt_customer
          @braintree_service = braintree_service
        end

        def build
          assert_customer_does_not_already_have_active_subscription
          payload
        end

        private

        def payload
          # TODO: Add promo hash
          # args.merge!(promo_hash(args.delete(:promo_code_id)))
          {
            payment_method_token: default_payment_method_token,
            plan_id: params[:plan_id],
          }
        end

        def default_payment_method_token
          # TODO: Use user payment method token here
          unless bt_customer.payment_methods.any?
            raise Unity::BraintreeGateway::NoCustomerPaymentMethodError
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
            raise Unity::BraintreeGateway::ActiveSubscriptionError
          end
        end
      end
    end
  end
end
