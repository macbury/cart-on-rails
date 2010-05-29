class CreateVendors < ActiveRecord::Migration
  def self.up
    create_table :vendors do |t|
      t.string :name
      t.string :permalink
      t.integer :shop_id
      t.timestamps
    end
    
    add_column :products, :vendor_id, :integer
  end
  
  def self.down
    drop_table :vendors
  end
end
