class Unity::ApplicationController < ActionController::Base
# class ApplicationController < ::ApplicationController
  protect_from_forgery with: :exception
end
