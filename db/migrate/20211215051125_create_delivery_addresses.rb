class CreateDeliveryAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_addresses do |t|
      t.integer :customer_id
      t.string :post_code
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
