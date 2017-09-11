require "unity/engine"
require "haml"

module Unity
  # Subscription belongs to user by default unless otherwise specified
  mattr_accessor :user_class
  @@user_class = "User"
end
