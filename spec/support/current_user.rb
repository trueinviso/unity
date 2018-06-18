module CurrentUser
  def stub_current_user(user_id = 1)
    Unity::ApplicationController.class_eval do
      define_method :current_user do
        User.find_or_create_by(id: user_id)
      end
    end
  end
end

RSpec.configure do |config|
  config.include CurrentUser
end
