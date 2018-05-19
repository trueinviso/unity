class CreateUnityGatewayCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :unity_gateway_customers do |t|
      t.string :gateway_id
      t.integer :gateway_type
      t.references :user, index: true

      t.timestamps
    end
  end
end
