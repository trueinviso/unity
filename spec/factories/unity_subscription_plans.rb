FactoryGirl.define do
  factory :unity_subscription_plan, class: 'Unity::SubscriptionPlan' do
    sequence(:gateway_id) { |n| "plan-#{n}" }
    price "19.99"
    period "monthly"
    # rank 50

    factory :premium_monthly_plan do
      name "Premium Plan"
      gateway_id "premium_monthly_subscription"
      group_enrollment_add_on_price 10.00
    end

    factory :basic_monthly_plan do
      name "Basic Plan"
      gateway_id "basic_monthly_subscription"
      group_enrollment_add_on_price 5.00
      price "9.99"
    end

    factory :free_plan do
      name "Free Plan"
      gateway_id "free_plan"
      price "0"
    end
  end
end
