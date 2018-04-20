module Unity
  module BraintreeGateway
    module Plan
      extend self
      mattr_reader :braintree_service, default: BraintreeService

      def plans
        braintree_service.braintree_plans
      end

      def plan_by_id(plan_id)
        plans.find { |p| p.id == plan_id }
      end
    end
  end
end
