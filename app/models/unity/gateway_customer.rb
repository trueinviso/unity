module Unity
  class GatewayCustomer < ApplicationRecord
    belongs_to :user, class_name: Unity.config.user_class

    enum gateway_type: {
      braintree: 0,
      stripe: 1,
    }
  end
end
