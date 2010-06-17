class CreateOptionTypesProducts < ActiveRecord::Migration
  def self.up
		create_table :option_types_products, :id => false do |t|
      t.integer :option_type_id
			t.integer :product_id
    end
  end

  def self.down
		drop_table :option_types_products
  end
end
