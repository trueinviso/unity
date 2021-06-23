require "rails_helper"

RSpec.describe Unity::Subscription, type: :model do
  it { should belong_to :subscription_plan }
  it { should belong_to Unity.config.user_class.downcase.to_sym }

  context "when cancelling a subscription" do
    context "when the subscription is still active" do

      let(:subscription) do
        build(
          :unity_subscription,
          gateway_status: :active,
          marked_for_cancellation_at: Time.currents,
          cancellation_date: 2.days.from_now,
        )
      end

      it "responds true to #awaiting_cancellation?" do
        expect(subscription.awaiting_cancellation?).to eq true
      end
    end
  end
end
