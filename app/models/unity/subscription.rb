module Unity
  class Subscription < ApplicationRecord
    belongs_to :user, class_name: Unity.config.user_class
    belongs_to :subscription_plan

    enum gateway_status: {
      active: 0,
      canceled: 1,
      expired: 2,
      past_due: 3,
      pending: 4,
      trialing: 5,
      unpaid: 6,
    }

    enum gateway_type: {
      braintree: 0,
      stripe: 1,
    }

    def previously_subscribed?
      gateway_id.present?
    end

    def trial?
      !trial_expired?
    end

    def paid?
      previously_subscribed? &&
        active?
    end

    def trial_expired?
      return true unless trial_ends_at.present?
      trial_ends_at < Time.current
    end
  end
end
