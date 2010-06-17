class AddPriceToVariants < ActiveRecord::Migration
  def self.up
    add_column :variants, :price, :float
    add_column :variants, :amount, :integer
  end

  def self.down
    remove_column :variants, :amount
    remove_column :variants, :price
  end
end
