class AddPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :max_price, :float, :default => 0.0
    add_column :products, :min_price, :float, :default => 0.0
  end

  def self.down
    remove_column :products, :min_price
    remove_column :products, :max_price
  end
end
