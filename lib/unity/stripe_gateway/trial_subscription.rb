module Unity
  module StripeGateway
    module TrialSubscription
      extend self

      def start(user, trial_ends_at = 1.week.from_now)
        return if user.subscription.present?
        build_local_subscription(user, trial_ends_at)
      end

      private

      def build_local_subscription(user, trial_ends_at)
        Subscription.create!(
          subscription_plan: SubscriptionPlan.find_by(name: "trial"),
          trial_ends_at: trial_ends_at,
          user: user,
        )
      end
    end
  end
end
