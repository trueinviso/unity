module Unity
  class Subscription < ApplicationRecord
    belongs_to :user, class_name: Unity.user_class
  end
end
