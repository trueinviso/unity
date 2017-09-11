FactoryGirl.define do
  factory :unity_subscription_plan, class: 'Unity::SubscriptionPlan' do
    sequence(:gateway_name) { |n| "plan-#{n}" }
    price "19.99"
    period "monthly"
    rank 50

    factory :premium_monthly_plan do
      gateway_name "premium_monthly_subscription"
      group_enrollment_add_on_price 10.00
    end
  end
end
