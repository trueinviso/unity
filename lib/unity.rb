require_relative "unity/version"
require "haml"
require "braintree"

# The main class for Unity.  Unity is build completely out of plugins, with the
# default plugin being Unity::UnityPlugins::Base
# Credit for this pattern given to Jeremy Evans, author of the Roda gem.
class Unity
  # autoload :BraintreeGateway, "unity/braintree_gateway"
  # autoload :GatewayActions, "unity/gateway_actions"
  # Subscription belongs to user by default unless otherwise specified
  # mattr_accessor :user_class
  # @@user_class = "User"

  class UnityError < StandardError; end

  # Module in which all Unity plugins should be stored. Also contains logic for
  # registering and loading plugins.
  module UnityPlugins
    OPTS = {}.freeze
    EMPTY_ARRAY = [].freeze

    @plugins = {}

    class << self
      # Make warn a public method, as it is used for deprecation warnings.
      # Unity::UnityPlugins.warn can be overridden for custom handling of
      # deprecation warnings.
      public :warn
    end

    # If the registered plugin already exists, use it.  Otherwise,
    # require it and return it.  This raises a LoadError if such a
    # plugin doesn't exist, or a UnityError if it exists but it does
    # not register itself correctly.
    def self.load_plugin(name)
      h = @plugins
      unless plugin = h[name]
        require "unity/plugins/#{name}"
        raise UnityError, "Plugin #{name} did not register itself correctly in Unity::UnityPlugins" unless plugin = h[name]
      end
      plugin
    end

    # Register the given plugin with Unity, so that it can be loaded using #plugin
    # with a symbol.  Should be used by plugin files.  Example:
    #
    #   Unity::UnityPlugins.register_plugin(:plugin_name, PluginModule)
    def self.register_plugin(name, mod)
      @plugins[name] = mod
    end

    # Deprecate the constant with the given name in the given module,
    # if the ruby version supports it
    def self.deprecate_constant(mod, name)
      # :nocov:
      if RUBY_VERSION >= "2.3"
        mod.deprecate_constant(name)
      end
      # :nocov:
    end

    # The base plugin for Unity, implementing all default functionality.
    # Methods are not put into a plugin so future plugins can easily override
    # them and call super to get the default behavior.
    module Base
      # Class methods for the Unity class
      module ClassMethods
        # When inheriting Unity, copy the shared data into the subclass
        def inherited(subclass)
          # raise UnityError, "Cannot subclass a frozen Unity class" if frozen?
          super
        end

        # Load a new plugin into the current class.  A plugin can be a module
        # which is used directly, or a symbol representing a registered plugin
        # which will be required and then used.  Returns nil.
        #
        #   Unity.plugin PluginModule
        #   Unity.plugin :braintree
        def plugin(plugin, *args, &block)
          # raise UnityError, "Cannot add a plugin to a frozen Unity class" if frozen?
          plugin = UnityPlugins.load_plugin(plugin) if plugin.is_a?(Symbol)
          plugin.load_dependencies(self, *args, &block) if plugin.respond_to?(:load_dependencies)
          include(plugin::InstanceMethods) if defined?(plugin::InstanceMethods)
          extend(plugin::ClassMethods) if defined?(plugin::ClassMethods)
          plugin.configure(self, *args, &block) if plugin.respond_to?(:configure)
          nil
        end

        # Convenience method to set braintree configurations.
        def configure_braintree(environment:, merchant_id:, public_key:, private_key:)
          raise UnityError, "Plugin `braintree_gateway` did not register itself correclty in Unity::UnityPlugins" unless plugins[:braintree_gateway]
          UnityPlugins::BraintreeGateway::Configuration.environment = environment
          UnityPlugins::BraintreeGateway::Configuration.merchant_id = merchant_id
          UnityPlugins::BraintreeGateway::Configuration.public_key = public_key
          UnityPlugins::BraintreeGateway::Configuration.private_key = private_key
        end

        # Get hash of registered plugins
        def plugins
          UnityPlugins.instance_variable_get(:@plugins)
        end
      end

      # Instance methods for the Unity class.
      module InstanceMethods
        def initialize
        end
      end
    end
  end

  extend UnityPlugins::Base::ClassMethods
  plugin UnityPlugins::Base
end
