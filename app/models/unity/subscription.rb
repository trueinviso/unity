module Unity
  class Subscription < ApplicationRecord
    belongs_to :user, class_name: Unity.user_class
    belongs_to :subscription_plan

    enum gateway_status: {
      active: 0,
      canceled: 1,
      expired: 2,
      past_due: 3,
      pending: 4,
    }

    enum gateway_type: {
      braintree: 0,
      stripe: 1,
    }

    def previously_subscribed?
      gateway_id.present?
    end
  end
end
