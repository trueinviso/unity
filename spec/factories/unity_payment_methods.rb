FactoryGirl.define do
  factory :unity_payment_method, class: "Unity::PaymentMethod" do
    sequence(:gateway_id) { "unity_#{Rails.env}_#{rand(1..100)}" }
  end
end
