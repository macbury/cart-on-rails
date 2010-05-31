class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.integer :shop_id
      t.string :name
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :themes
  end
end
