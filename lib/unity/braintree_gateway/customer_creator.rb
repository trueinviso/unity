module Unity
  module BraintreeGateway
    class CustomerCreator
      attr_reader :user, :params, :braintree_service

      def initialize(user:, params:, braintree_service: BraintreeService)
        @user = user
        @params = params
        @braintree_service = braintree_service
      end

      def find_or_create_customer
        get_customer
      end

      private

      def get_customer
        result = find_customer if user.gateway_customer_id.present?
        result = create_customer unless result&.success?
        update_local_user(result) if result.success?
        result
      end

      def find_customer
        braintree_service.find_customer(user.gateway_customer_id)
      end

      def create_customer
        braintree_service.create_customer(build_create_customer_payload)
      end

      def build_create_customer_payload
        {
          id: generate_gateway_id,
          first_name: params[:first_name],
          last_name: params[:last_name],
          email: user.email,
          payment_method_nonce: params[:payment_method_nonce],
        }
      end

      def update_local_user(result)
        user.update!(
          gateway_customer_id: result.customer.id,
          payment_token: result.customer.default_payment_method.token,
        )
      end

      def generate_gateway_id
        name = Rails.application.class.parent_name.downcase
        if Rails.env.development?
          # Make unique gateway id for Braintree sandbox
          "#{name}_#{Rails.env}_#{user.id}-#{SecureRandom.hex(4)}"
        else
          "#{name}_#{Rails.env}_#{user.id}"
        end
      end
    end
  end
end
