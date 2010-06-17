class CreateVariants < ActiveRecord::Migration
  def self.up
    create_table :variants do |t|
      t.integer :product_id
      t.string :sku
      t.integer :weight
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :variants
  end
end
