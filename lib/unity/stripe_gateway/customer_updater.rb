module Unity
  module StripeGateway
    class CustomerUpdater
      attr_reader :params, :user

      def initialize(user, params)
        @params = params
        @user = user
      end

      def self.update!(user, params)
        new(user, params).call!
      end

      def call!
        result = update_customer
        update_local_payment_method(result)
        define_success_method(result)
      end

      private

      def update_customer
        cu = Stripe::Customer.retrieve(gateway_customer.gateway_id)
        cu.source = params[:payment_method_nonce]
        cu.save
      end

      def gateway_customer
        @gateway_customer ||= GatewayCustomer.find_by(user: user)
      end

      def update_local_payment_method(result)
        pm = PaymentMethod.find_by(user_id: user.id)
        pm.update!(gateway_id: result.default_source)
      end

      def define_success_method(result)
        result.define_singleton_method(:success?) do
          self.is_a?(Stripe::Customer)
        end
        result
      end
    end
  end
end
