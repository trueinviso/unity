class CreateUnitySubscriptionPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :unity_subscription_plans do |t|
      t.string :gateway_name, null: false
      t.string :period, null: false
      t.string :price, null: false
      t.integer :rank, null: false
      t.string :group_enrollment_add_on_price

      t.timestamps
    end
  end
end
