class Unity::ApplicationController < ActionController::Base
# class ApplicationController < ::ApplicationController
  protect_from_forgery with: :exception
  before_action :guard_user_authenticated!

  def guard_user_authenticated!
    redirect_to main_app.root_path if current_user.blank?
  end
end
