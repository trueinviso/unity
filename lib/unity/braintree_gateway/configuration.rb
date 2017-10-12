module Unity
  module BraintreeGateway
    class Configuration
      singleton_class.class_eval do
        delegate :environment,
                 :merchant_id,
                 :public_key,
                 :private_key,
                 :to => ::Braintree::Configuration

        delegate :environment=,
                 :merchant_id=,
                 :public_key=,
                 :private_key=,
                 :to => ::Braintree::Configuration
      end

      def self.load_plans
        plans = ::Braintree::Plan.all

        plans.each do |plan|
          local_plan = SubscriptionPlan.new
          local_plan.gateway_id = plan.id
          local_plan.price = plan.price.to_s
          local_plan.period = plan.billing_frequency
          local_plan.save!
        end
      end
    end
  end
end
