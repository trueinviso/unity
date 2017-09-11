FactoryGirl.define do
  factory :unity_subscription, class: "Unity::Subscription" do
    factory :premium_subscription do
      sequence(:gateway_id) { "btv_#{Rails.env}_#{rand(1..100)}" }
      association :subscription_plan, factory: :premium_monthly_plan
    end
  end
end
