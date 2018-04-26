module Unity
  class Configuration
    attr_accessor :user_class,
      :allow_multiple_subscriptions,
      :hosted_fields,
      :gateway_type,
      :stripe_publishable_key,
      :stripe_secret_key,
      :braintree_environment,
      :braintree_merchant_id,
      :braintree_public_key,
      :braintree_private_key


    def initialize
      @user_class = "User"
      @allow_multiple_subscriptions = false
      @hosted_fields = false
      @gateway_type = :braintree
    end

    def client_token
      case gateway_type
      when :braintree
        BraintreeGateway::Actions.generate_client_token
      when :stripe
        if stripe_publishable_key.blank?
          raise Errors::StripeGateway::NoStripePKKeyProvidedError
        end
        stripe_publishable_key
      end
    end

    def stripe?
      gateway_type == :stripe
    end

    def braintree?
      gateway_type == :braintree
    end
  end
end
