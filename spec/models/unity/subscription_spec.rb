require "rails_helper"

RSpec.describe Unity::Subscription, type: :model do
  it { should belong_to :subscription_plan }

  describe ".days_until_expiration" do
    let(:subscription) { build(:premium_subscription, trial_ends_at: 2.days.from_now) }

    it "has correct days until expiration" do
      expect(subscription.days_until_expiration).to eq 2
    end
  end

  describe ".trial_expired?" do
    let(:subscription) { build(:unity_subscription, trial_ends_at: Time.zone.now) }
    let(:expired_subscription) { build(:unity_subscription, trial_ends_at: 1.day.ago) }

    it "is expired" do
      expect(expired_subscription.trial_expired?).to be_truthy
    end

    it "is not expired" do
      expect(subscription.trial_expired?).to be_falsey
    end
  end

  describe ".trial?" do
    let(:subscription) { build(:unity_subscription, trial_ends_at: Time.zone.now, gateway_id: 123) }
    let(:trial_subscription) { build(:unity_subscription, trial_ends_at: Time.zone.now) }

    it "is not in trial" do
      expect(subscription.trial?).to be_falsey
    end

    it "is in trial" do
      expect(trial_subscription.trial?).to be_truthy
    end
  end

  describe ".free?" do
    let(:premium) { create(:premium_monthly_plan) }
    let(:free) { create(:unity_subscription_plan, price: 0, gateway_name: "free_plan") }

    let(:free_subscription) do
      build(:unity_subscription, trial_ends_at: 1.day.ago, subscription_plan: free)
    end

    let(:premium_subscription) { build(:premium_subscription) }

    it "is a free subscription" do
      assert(free_subscription.free?)
    end

    it "is not a free subscription" do
      refute(premium_subscription.free?)
    end
  end
end
