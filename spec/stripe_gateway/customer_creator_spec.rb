require "rails_helper"

module Unity
  module StripeGateway
    RSpec.describe CustomerCreator do
      let(:user) { create(:user) }

      describe ".call!" do
        it "creates local gateway customer" do
          result = described_class.call!(user)
          expect(user.reload.gateway_customer.gateway_id)
            .to eq result.id
        end

        it "raises NoUserProvided" do
          expect { described_class.call!(nil) }
            .to raise_error ::Unity::Errors::NoUserProvided
        end
      end
    end
  end
end
