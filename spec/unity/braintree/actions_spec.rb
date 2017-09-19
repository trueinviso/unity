require "rails_helper"

module Unity
  module Braintree
    RSpec.describe Actions do
      context ".create_subscription" do
        before { @user = create_user }

        it "creates local subscription" do
          params = {
            payment_method_nonce: "fake-nonce",
            plan_id: "basic_monthly_subscription",
          }
          described_class.create_customer_subscription(@user, params)
          assert_equal @user, Unity::Subscription.first.user
        end
      end

      def create_user
        user_class = Object.const_set("User", Class.new(ActiveRecord::Base))
        user_class.table_name = :users
        user_class.create!
      end
    end
  end
end
