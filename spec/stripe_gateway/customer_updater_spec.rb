require "rails_helper"

module Unity
  module StripeGateway
    RSpec.describe CustomerUpdater do
      let(:user) { create(:user, :with_gateway_customer, :with_payment_method) }

      describe ".call!" do
        it "creates local gateway customer" do
          expect_any_instance_of(described_class)
            .to receive(:update_local_payment_method)

          result = described_class.update!(user, valid_params)
          expect(user.reload.gateway_customer.gateway_id)
            .to eq result.id
        end
      end

      private

      def valid_params
        {
          payment_method_nonce: "fake-valid-nonce",
        }
      end
    end
  end
end
