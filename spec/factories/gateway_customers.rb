FactoryGirl.define do
  factory :gateway_customer, class: "Unity::GatewayCustomer" do
    sequence(:gateway_id) { "unity_#{Rails.env}_#{rand(1..100)}" }
    gateway_type :stripe
  end
end
