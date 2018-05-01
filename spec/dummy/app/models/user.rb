class User < ApplicationRecord
  has_one :subscription, class_name: "Unity::Subscription"
  has_one :payment_method, class_name: "Unity::PaymentMethod"
  has_one :gateway_customer, class_name: "Unity::GatewayCustomer"
end
