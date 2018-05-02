require "rails_helper"

module Unity
  module StripeGateway
    RSpec.describe SubscriptionCanceller do
      let(:user) { create(:user) }
      let(:subscription) { create(:unity_subscription, user: user) }

      before { ::Timecop.freeze(Time.now) }
      after { ::Timecop.return }

      describe ".call!" do
        it "cancels subscription" do
          result = described_class.call!(subscription).result
          expect(subscription.reload.marked_for_cancellation_at)
            .to eq Time.now
          expect(subscription.cancellation_date)
            .to eq Time.at(result.current_period_end)
        end

        it "raises SubscriptionCancelError" do
          allow_any_instance_of(SubscriptionCanceller::Result)
            .to receive(:success?)
            .and_return(false)

          expect { described_class.call!(subscription) }
            .to raise_error Errors::SubscriptionCancelError
        end
      end
    end
  end
end
