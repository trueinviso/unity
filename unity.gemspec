require File.expand_path("../lib/unity/version", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "unity"
  s.version     = Unity::UnityVersion
  s.authors     = ["Keith Ward"]
  s.email       = ["trueinviso@gmail.com"]
  s.summary     = "Rails Engine that provides subscription functionality for Braintree."
  s.license     = "MIT"

  # s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.files = %w"README.md MIT-LICENSE" + Dir["{lib,spec}/**/*.rb"]
  # s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency "braintree", "~> 2.78"
  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "haml", "~> 5.0"
  s.add_dependency "sass-rails"

  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "foundation-rails"
  s.add_development_dependency "webvalve"
end
