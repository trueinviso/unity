# This file is copied to spec/ when you run 'rails generate rspec:install'
RSpec.configure do |config|
  config.include ::Rails::Controller::Testing::TestProcess, type: :controller
  config.include ::Rails::Controller::Testing::Integration, type: :controller
  config.include ::Rails::Controller::Testing::TemplateAssertions, type: :controller
end
