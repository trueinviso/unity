module Unity
  class SubscriptionPlan < ApplicationRecord
    def free?
      gateway_name == "free_plan"
    end
  end
end
