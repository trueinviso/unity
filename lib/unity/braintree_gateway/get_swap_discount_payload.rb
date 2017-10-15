module Unity
  module BraintreeGateway
    class GetSwapDiscountPayload
      attr_reader :bt_subscription
      attr_reader :new_plan
      attr_reader :current_plan

      def initialize(swap_builder)
        @bt_subscription = swap_builder.bt_subscription
        @new_plan = swap_builder.new_plan
        @current_plan = swap_builder.current_plan
      end

      def build
        payload
      end

      private

      def payload
        return {} if free_plan?
        plan_credits = switching_to_monthly_plan? ? switch_to_monthly_discount : switch_to_yearly_discount
        DiscountHashBuilder.new(plan_credits: plan_credits).build
      end

      def free_plan?
        new_plan.price == 0
      end

      def switching_to_monthly_plan?
        current_plan.billing_frequency == 12 && new_plan.billing_frequency == 1
      end

      def switch_to_monthly_discount
        number_of_billing_cycles = (money_remaining_on_yearly_plan / new_plan.price).floor
        { amount: new_plan.price, number_of_billing_cycles: number_of_billing_cycles }
      end

      def money_remaining_on_yearly_plan
        return 0 if bt_subscription.trial_period
        current_plan_price_per_day * paid_days_remaining
      end

      def current_plan_price_per_day
        current_plan.price.to_f / 365
      end

      def paid_days_remaining
        (bt_subscription.billing_period_end_date.to_date - DateTime.now).to_i
      end

      def switch_to_yearly_discount
        amount = 0

        for discount in bt_subscription.discounts
          amount = amount + amount_for(discount)
        end

        { amount: amount, number_of_billing_cycles: 1 }
      end

      def amount_for(discount)
        discount.amount * discount.number_of_billing_cycles
      end
    end
  end
end
