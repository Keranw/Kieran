class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.float :price
      t.integer :owner_id
      t.string :description

      t.timestamps null: false
    end
  end
end
