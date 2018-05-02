class CreateUnitySubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :unity_subscriptions do |t|
      t.string :gateway_id
      t.integer :gateway_status
      t.integer :gateway_type
      t.boolean :group_enrolled
      t.references :subscription_plan, index: true
      t.datetime :trial_ends_at
      t.datetime :cancellation_date
      t.datetime :marked_for_cancellation_at
      t.references :user, index: true

      t.timestamps
    end
  end
end
