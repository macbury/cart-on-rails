class CreateProductProperties < ActiveRecord::Migration
  def self.up
    create_table :product_properties do |t|
      t.integer :product_id
      t.integer :property_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :product_properties
  end
end
