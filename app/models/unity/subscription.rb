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

    scope :expiring, -> {
      includes(:user)
        .where(trial_ends_at: 1.day.from_now.beginning_of_day..2.days.from_now.end_of_day)
    }

    def days_until_expiration
      return 0 unless trial_ends_at.present?
      trial_ends_at.to_date.mjd - Time.zone.now.to_date.mjd
    end

    def trial_expired?
      return true unless trial_ends_at.present?
      trial_ends_at.end_of_day < Time.zone.today
    end

    def trial?
      !trial_expired? && !subscribed?
    end

    def free?
      trial_expired? && subscription_plan.free?
    end

    def premium_monthly?
      subscription_plan.gateway_name == "premium_monthly_subscription"
    end

    def cancelled?
      gateway_status == "canceled"
    end

    def subscribed?
      gateway_id.present?
    end
  end
end
