module SubscriptionResponse
  extend self

  def build(attributes = {})
    {
      subscription: {
        id: attributes[:id] || Random.new.rand(100000),
        status: "Active",
        transactions: [],
        add_ons: [],
        discounts: []
      }
    }
  end
end
