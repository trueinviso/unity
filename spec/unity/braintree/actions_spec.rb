require "rails_helper"

module Unity
  module BraintreeGateway
    RSpec.describe Actions do
      describe ".create_customer_subscription" do
        before { configure_braintree }
        let(:user) { create_user }
        let!(:plan) { create(:premium_monthly_plan) }

        it "creates local subscription" do
          params = {
            payment_method_nonce: "fake-nonce",
            plan_id: "premium_monthly_subscription",
          }
          described_class.create_customer_subscription(user, params)
          created_subscription = ::Unity::Subscription.first
          assert_equal user, created_subscription.user
          assert created_subscription.active?
          assert_equal created_subscription.subscription_plan_id, plan.id
          assert_equal created_subscription.user_id, user.id
        end
      end

      def create_user
        user_class = Object.const_set("User", Class.new(ActiveRecord::Base) do
          self.table_name = "users"
          attr_accessor :gateway_customer_id
        end)
        user_class.create!
      end
    end
  end
end
