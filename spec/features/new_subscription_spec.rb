require "rails_helper"

feature "User applies for new subscription" do
  let(:user) { create(:user, :with_gateway_customer) }

  before do
    Unity.config.gateway_type = :stripe
    Unity.config.stripe_publishable_key = "pk_test_123"
    stub_current_user(user.id)
  end

  scenario "User signs up for premium monthly", js: true do
RSpec.configure do |config|
  config.include ::Rails::Controller::Testing::TestProcess, type: :controller
  config.include ::Rails::Controller::Testing::Integration, type: :controller
  config.include ::Rails::Controller::Testing::TemplateAssertions, type: :controller
end
    visit unity.new_subscription_path
    save_and_open_page
    fill_in :cardnumber, with: "4111111111111111"
  end
end
