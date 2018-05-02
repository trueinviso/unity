require 'rails_helper'

module Unity
  RSpec.describe SubscriptionPlan, type: :model do
    let(:free_plan) { build(:free_plan) }
    let(:premium_plan) { build(:premium_monthly_plan) }

    describe "#free?" do
      context "free plan" do
        it "returns true" do
          expect(free_plan.free?)
            .to be_truthy
        end
      end

      context "premium plan" do
        it "returns false" do
          expect(premium_plan.free?)
            .to be_falsey
        end
      end
    end

    describe "#display_name?" do
      context "fake-id and $10 price" do
        it "returns display name" do
          expect(premium_plan.display_name)
            .to eq "#{premium_plan.gateway_id} - $#{premium_plan.price}"
        end
      end
    end
  end
end
