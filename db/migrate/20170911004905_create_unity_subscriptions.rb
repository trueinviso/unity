class CreateUnitySubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :unity_subscriptions do |t|
      t.references :user, index: true
      t.references :subscription_plan, index: true
      t.string :gateway_id
      t.integer :gateway_status
      t.integer :gateway_type
      t.datetime :trial_ends_at
      t.boolean :group_enrolled

      t.timestamps
    end
  end
end
