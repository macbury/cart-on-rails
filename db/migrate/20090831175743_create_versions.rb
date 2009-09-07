class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.string :name
      t.float :price, :default => 0.0
      t.integer :amount, :default => 0
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :versions
  end
end
