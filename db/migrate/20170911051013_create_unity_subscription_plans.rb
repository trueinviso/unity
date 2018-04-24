class CreateUnitySubscriptionPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :unity_subscription_plans do |t|
      t.string :gateway_id
      t.string :period
      t.string :price
      t.string :group_enrollment_add_on_price
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
