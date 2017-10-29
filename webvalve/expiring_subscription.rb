module ExpiringSubscription
  extend self

  def build(attributes = {})
    {
      subscription: {
        id: attributes[:id] || Random.new.rand(100000),
        number_of_billing_cycles: attributes[:"number-of-billing-cycles"],
        status: "Active",
        transactions: [],
        add_ons: [],
        discounts: []
      }
    }
  end
end
