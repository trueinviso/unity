module Unity
  module BraintreeGateway
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
        BraintreeService.update_customer(
          user,
          update_customer_args,
        )
      end

      private

      def update_customer_args
        {
          email: user.email,
          first_name: params[:first_name],
          last_name: params[:last_name],
          payment_method_nonce: params[:payment_method_nonce],
          phone: params[:phone],
          credit_card: payment_method_args,
        }
      end

      def payment_method_args
        {
          billing_address: billing_address_args,
          options: {
            update_existing_token: user.payment_token,
            make_default: true,
          },
        }.merge(billing_address_args)
      end

      def billing_address_args
        return {} unless billing_data_present?
        {
          first_name: params[:first_name],
          last_name: params[:last_name],
          street_address: params[:address],
          locality: params[:city],
          region: params[:state],
          postal_code: params[:billing_zip],
          options: { update_existing: true },
        }
      end

      def billing_data_present?
        params[:first_name].present? ||
          params[:last_name].present? ||
          params[:address].present? ||
          params[:city].present? ||
          params[:state].present? ||
          params[:billing_zip].present?
      end
    end
  end
end
