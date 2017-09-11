$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "unity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "unity"
  s.version     = Unity::VERSION
  s.authors     = ["Keith Ward"]
  s.email       = ["trueinviso@gmail.com"]
  s.summary     = "Rails Engine that provides subscription functionality for Braintree."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.1.4"
  s.add_dependency "haml"

  s.add_development_dependency "sqlite3"
end
