require "rails_helper"

module Unity
  module StripeGateway
    RSpec.describe Actions do
      let(:user) { create(:user, :with_gateway_customer) }
      let!(:plan) { create(:premium_monthly_plan) }

      describe ".create_customer_subscription" do
        it "calls subscription creator" do
          expect(SubscriptionCreator)
            .to receive(:create!)

          described_class
            .create_customer_subscription(user, valid_params)
        end

        it "calls customer creator" do
          expect(CustomerCreator)
            .to receive(:call!)

          described_class
            .create_customer(user)
        end

        it "calls subscription canceller" do
          expect(SubscriptionCanceller)
            .to receive(:call!)

          described_class
            .cancel_subscription(user.subscription)
        end

        it "calls subscription updater" do
          expect(SubscriptionUpdater)
            .to receive(:call!)

          described_class
            .update_subscription(user.subscription, valid_params)
        end

        it "calls customer updater" do
          expect(CustomerUpdater)
            .to receive(:update!)

          described_class
            .update_customer(user, valid_params)
        end
      end

      private

      def mock_local_payment_creation
        expect_any_instance_of(SubscriptionCreator)
          .to receive(:create_local_payment_method)
          .and_return(true)
      end

      def valid_params
        {
          payment_method_nonce: "tok_br",
          plan_id: "premium_monthly_subscription",
        }
      end
    end
  end
end
