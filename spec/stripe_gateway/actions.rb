require "rails_helper"

module Unity
  module StripeGateway
    RSpec.describe Actions do
      let(:user) { create(:user, :with_gateway_customer) }
      let!(:plan) { create(:premium_monthly_plan) }

      describe ".create_customer_subscription" do
        it "creates local subscription" do
          mock_local_payment_creation
          params = {
            payment_method_nonce: "tok_br",
            plan_id: "premium_monthly_subscription",
          }

          result = described_class
            .create_customer_subscription(user, params)
            .result

          subscription = user.reload.subscription
          expect(subscription.gateway_id).to eq(result.id)
          expect(subscription.subscription_plan_id).to eq(plan.id)
          expect(subscription.gateway_type).to eq "stripe"
          expect(subscription.gateway_status).to eq "active"
        end
      end

      private

      def mock_local_payment_creation
        expect_any_instance_of(SubscriptionCreator)
          .to receive(:create_local_payment_method)
          .and_return(true)
      end
    end
  end
end
