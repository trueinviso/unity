module Unity
  module BraintreeGateway
    class UpdateSubscriptionPayload
      attr_reader :bt_subscription
      attr_reader :params
      attr_reader :braintree_service

      def self.build(bt_subscription, params)
        new(bt_subscription, params).build
      end

      def initialize(bt_subscription, params)
        @bt_subscription = bt_subscription
        @params = params
      end

      def build
        payload
      end

      private

      def payload
        # TODO: Add promo hash
        # args.merge!(promo_hash(args.delete(:promo_code_id)))
        payload = plan_payload
        payload
      end

      def plan_payload
        {
          plan_id: params[:plan_id],
        }
      end
    end
  end
end
