module Unity
  module StripeGateway
    class CustomerCreator
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def self.call!(user)
        raise ::Unity::Errors::NoUserProvided if user.blank?
        new(user).create
      end

      def create
        result = create_stripe_customer
        create_local_customer(result)
        result
      end

      private

      def create_stripe_customer
        ::Stripe::Customer.create(
          email: user.email,
        )
      end

      def create_local_customer(result)
        customer = GatewayCustomer
          .find_or_initialize_by(user: user)

        customer.update!(
          gateway_id: result.id,
          gateway_type: :stripe,
        )
      end
    end
  end
end
