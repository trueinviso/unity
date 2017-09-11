require 'test_helper'

module Unity
  class SubscriptionControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get new" do
      get subscription_new_url
      assert_response :success
    end

  end
end
