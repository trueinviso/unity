module Unity
  module BraintreeGateway
    class DiscountHashBuilder
      attr_reader :plan_credits

      def initialize(plan_credits: nil)
        @plan_credits = plan_credits
      end

      def build
        discounts_hash
      end

      private

      def discounts_hash
        {
          discounts: {
            add: [
              plan_credit_hash,
            ]
          }
        }
      end

      def plan_credit_hash
        return {} unless plan_credits.present?
        {
          inherited_from_id: "plan-credit",
          amount: plan_credits[:amount],
          number_of_billing_cycles: plan_credits[:number_of_billing_cycles],
        }
      end
    end
  end
end
