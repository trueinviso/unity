class CreateUnitySubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :unity_subscriptions do |t|
      t.references Unity.user_class.downcase.to_sym, index: true
      t.references :subscription_plan, index: true
      t.string :gateway_id
      t.integer :gateway_status
      t.datetime :trial_ends_at
      t.boolean :group_enrolled

      t.timestamps
    end
  end
end
