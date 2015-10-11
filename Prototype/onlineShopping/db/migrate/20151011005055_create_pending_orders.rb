class CreatePendingOrders < ActiveRecord::Migration
  def change
    create_table :pending_orders do |t|
      t.string :buyer
      t.string :seller
      t.string :items
      t.float :totalprice
      t.string :purchasetime

      t.timestamps null: false
    end
  end
end
