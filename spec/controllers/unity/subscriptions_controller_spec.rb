require "rails_helper"
require "rails/controller/testing/test_process"
require "rails/controller/testing/integration"
require "rails/controller/testing/template_assertions"

module Unity
  describe SubscriptionsController, type: :controller do
    routes { Unity::Engine.routes }

    let(:user) { create(:user, :with_gateway_customer) }

    before do
      Unity.config.gateway_type = :stripe
      Unity.config.stripe_publishable_key = "pk_test_123"
      stub_current_user(user.id)
    end

    describe "#new" do
      it "sets token" do
        get :new
        pp assigns(:token)
      end
    end

    describe "#create" do
    end

    describe "#edit" do
    end

    describe "#update" do
    end

    describe "#destroy" do
    end
  end
end
