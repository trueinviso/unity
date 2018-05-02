module Unity
  class SubscriptionPlan < ApplicationRecord
    def free?
      gateway_id == "free_plan"
    end

    def display_name
      "#{gateway_id} - $#{price}"
    end
  end
end
