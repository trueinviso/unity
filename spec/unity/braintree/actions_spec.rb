require "rails_helper"

module Unity
  module BraintreeGateway
    RSpec.describe Actions do
      before { configure_braintree }
      let(:user) { create_user }
      let(:subscription) { create(:unity_subscription, user: user) }
      let!(:plan) { create(:premium_monthly_plan) }

      describe ".create_customer_subscription" do
        it "creates local subscription" do
          params = {
            payment_method_nonce: "fake-nonce",
            plan_id: "premium_monthly_subscription",
          }
          configure_response("CustomerResponse", "SubscriptionResponse")
          described_class.create_customer_subscription(user, params)
          created_subscription = ::Unity::Subscription.first
          assert_equal user.id, created_subscription.user.id
          assert created_subscription.active?
          assert_equal created_subscription.subscription_plan_id, plan.id
          assert_equal created_subscription.user_id, user.id
        end
      end

      describe ".cancel_subscription" do
        it "sets current billing cycle to be last billing cycle" do
          configure_response(nil, "ExpiringSubscription")
          result = described_class.cancel_subscription(subscription)
          expect(result.subscription.number_of_billing_cycles).to eq "1"
        end
      end

      describe ".update_subscription" do
      end

      describe ".generate_client_token" do
      end

      def create_user
        user_class = Object.const_set("User", Class.new(ActiveRecord::Base) do
          self.table_name = "users"
          attr_accessor :gateway_customer_id
        end)
        user_class.create!
      end

      def configure_response(customer, subscription)
        configure_fake_braintree_response({
          customer: customer,
          subscription: subscription,
        })
      end
    end
  end
end
