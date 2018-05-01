require "rails_helper"

module Unity
  module StripeGateway
    RSpec.describe SubscriptionCreator do
      let(:user) { create(:user, :with_gateway_customer) }
      let!(:plan) { create(:premium_monthly_plan) }

      describe ".create!" do
        it "creates local subscription" do
          mock_local_payment_creation

          result = described_class
            .create!(user, valid_params)
            .result

          subscription = user.reload.subscription
          expect(subscription.gateway_id).to eq(result.id)
          expect(subscription.subscription_plan_id).to eq(plan.id)
          expect(subscription.gateway_type).to eq "stripe"
          expect(subscription.gateway_status).to eq "active"
        end

        it "raises NullCustomerGatewayIdError" do
          user = create(:user)
          expect { described_class.create!(user, {}) }
            .to raise_error Errors::NullCustomerGatewayIdError
        end

        it "raises NullPlanIdError" do
          params = { payment_method_nonce: "tok_br" }
          expect { described_class.create!(user, params) }
            .to raise_error Errors::NullPlanIdError
        end

        it "raises NullSourceError" do
          params = { plan_id: "premium_monthly_subscription" }
          expect { described_class.create!(user, params) }
            .to raise_error Errors::NullSourceError
        end

        it "raises SubscriptionCreateError" do
          allow_any_instance_of(SubscriptionCreator::Result)
            .to receive(:success?)
            .and_return(false)

          expect { described_class.create!(user, valid_params) }
            .to raise_error Errors::SubscriptionCreateError
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
