require "rails_helper"

module Unity
  module BraintreeGateway
    RSpec.describe CreateSubscriptionPayload do
      before do
        configure_braintree
        @params = { plan_id: "fake-plan-id" }
      end

      describe "#build" do
        context "valid customer" do
          it "Without a discount payload" do
            test_object = initialize_test_object(@params, "CustomerResponse")
            expect(test_object.create_payload)
              .to eq test_object.payload_result
          end

          it "With a discount payload" do
          end
        end

        context "customer with active subscription" do
          it "raises active subscription error" do
            test_object = initialize_test_object(@params, "CustomerWithActiveSubscription")
            expect{ test_object.create_payload }
              .to raise_error(Errors::ActiveSubscriptionError)
          end
        end

        context "customer with no payment method" do
          it "raises no payment method error" do
            test_object = initialize_test_object(@params, "CustomerWithoutPaymentMethod")
            expect{ test_object.create_payload }
              .to raise_error(Errors::NoCustomerPaymentMethodError)
          end
        end
      end

      def initialize_test_object(params, response_class, discounts = {})
        PayloadTestObject.new(
          params: params,
          response_class: response_class,
          discounts: discounts,
        )
      end

      private

      class PayloadTestObject
        attr_reader :bt_customer
        attr_reader :discounts
        attr_reader :params
        attr_reader :response_class

        def initialize(discounts:, params:, response_class:)
          FakeBraintree.response_class = {
            customer: response_class,
            subscription: "SubscriptionResponse",
          }
          @params = params
          @discounts = discounts
        end

        def bt_customer
          @bt_customer ||= BraintreeService.create_customer({}).customer
        end

        def create_payload
          CreateSubscriptionPayload.new(
            bt_customer: bt_customer,
            params: params,
          ).build
        end

        def payload_result
          {
            payment_method_token: bt_customer.default_payment_method.token,
            plan_id: params[:plan_id],
            discounts: discounts,
          }
        end
      end
    end
  end
end
