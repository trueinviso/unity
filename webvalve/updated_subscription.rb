module UpdatedSubscription
  extend self

  def build(attributes = {})
    {
      subscription: {
        id: attributes[:id] || Random.new.rand(100000),
        plan_id: attributes[:"plan-id"],
        status: "Active",
        transactions: [],
        add_ons: [],
        discounts: []
      }
    }
  end
end
