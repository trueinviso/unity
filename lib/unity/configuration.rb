module Unity
  class Configuration
    attr_accessor :allow_multiple_subscriptions,
      :braintree_environment,
      :braintree_merchant_id,
      :braintree_private_key,
      :braintree_public_key,
      :gateway_type,
      :hosted_fields,
      :stripe_publishable_key,
      :stripe_secret_key,
      :user_class


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
