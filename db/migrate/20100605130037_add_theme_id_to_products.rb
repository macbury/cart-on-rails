class AddThemeIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :theme_id, :integer
  end

  def self.down
    remove_column :products, :theme_id
  end
end
