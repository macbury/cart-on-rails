class AddVatToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :vat, :integer
  end

  def self.down
    remove_column :products, :vat
  end
end
