require "rails_helper"

module Unity
  module StripeGateway
    RSpec.describe SubscriptionUpdater do
      let(:user) { create(:user) }
      let(:subscription) { create(:unity_subscription, user: user) }
      let(:basic_plan) { create(:basic_monthly_plan) }

      describe ".create!" do
        it "creates updates local subscription" do
          result = described_class
            .call!(subscription, valid_params)
            .result

          expect(subscription.reload.gateway_id).to eq(result.id)
          expect(subscription.subscription_plan_id).to eq(basic_plan.id)
          expect(subscription.gateway_type).to eq "stripe"
          expect(subscription.gateway_status).to eq "active"
        end

        it "raises NullPlanIdError" do
          expect { described_class.call!(subscription, {}) }
            .to raise_error Errors::NullPlanIdError
        end

        it "raises SubscriptionUpdateError" do
          allow_any_instance_of(SubscriptionUpdater::Result)
            .to receive(:success?)
            .and_return(false)

          expect { described_class.call!(subscription, valid_params) }
            .to raise_error Errors::SubscriptionUpdateError
        end
      end

      private

      def valid_params
        {
          plan_id: basic_plan.gateway_id,
        }
      end
    end
  end
end
