module Unity
  class Engine < ::Rails::Engine
    isolate_namespace Unity

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s+File::SEPARATOR
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer "unity.assets.precompile" do |app|
      app.config.assets.precompile += %w( application.js application.css )
    end
  end
end
