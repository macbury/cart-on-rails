class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :permalink
      t.integer :shop_id

      t.timestamps
    end
    
    add_column :products, :category_id, :integer
  end

  def self.down
    drop_table :categories
  end
end
