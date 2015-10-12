class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :buyer
      t.string :seller
      t.string :items
      t.float :totalprice

      t.timestamps null: false
    end
  end
end
