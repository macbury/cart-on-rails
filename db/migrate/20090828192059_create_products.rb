class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :permalink
      t.text :description
      t.integer :shop_id
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
