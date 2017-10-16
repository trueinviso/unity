require "rails_helper"

module Unity
  module BraintreeGateway
    RSpec.describe DiscountHashBuilder do
      let(:empty_discounts_hash) { { discounts: { add: [{}] } } }
      let(:plan_credits) { { amount: 10, number_of_billing_cycles: 10 } }

      let(:discounts_hash_with_plan_credits) do
        {
          discounts: {
            add: [
              {
                inherited_from_id: "plan-credit",
                amount: plan_credits[:amount],
                number_of_billing_cycles: plan_credits[:number_of_billing_cycles],
              }
            ]
          }
        }
      end

      it "with no plan credits" do
        expect(described_class.new.build).to eq empty_discounts_hash
      end

      it "with plan credits" do
        expect(described_class.new(plan_credits: plan_credits).build)
          .to eq discounts_hash_with_plan_credits
      end
    end
  end
end
