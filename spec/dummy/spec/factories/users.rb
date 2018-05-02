FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }

    trait :with_gateway_customer do
      after(:build) do |user|
        user.gateway_customer ||= FactoryGirl
          .build(:gateway_customer, user: user)
      end
    end

    trait :with_payment_method do
      after(:build) do |user|
        user.payment_method ||= FactoryGirl
          .build(:unity_payment_method, user: user)
      end
    end
  end
end
