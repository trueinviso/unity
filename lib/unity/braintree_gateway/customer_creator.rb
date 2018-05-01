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
        result = find_customer if gateway_customer&.gateway_id&.present?
        result = create_customer unless result&.success?
        create_local_customer(result) if result.success?
        create_local_payment_method(result) if result.success?
        result
      end

      def find_customer
        braintree_service.find_customer(gateway_customer.gateway_id)
      end

      def gateway_customer
        @gateway_customer ||= GatewayCustomer.find_by(user: user)
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

      def create_local_payment_method(result)
        payment_method = PaymentMethod
          .find_or_initialize_by(user: user)

        payment_method.update!(
          gateway_id: result.customer.default_payment_method.token,
          gateway_type: :stripe,
        )
      end

      def create_local_customer(result)
        customer = GatewayCustomer
          .find_or_initialize_by(user: user)

        customer.update!(
          gateway_id: result.customer.id,
          gateway_type: :braintree,
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
