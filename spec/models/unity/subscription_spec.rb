require "rails_helper"

RSpec.describe Unity::Subscription, type: :model do
  it { should belong_to :subscription_plan }
  it { should belong_to Unity.config.user_class.downcase.to_sym }
end
