class CreateShops < ActiveRecord::Migration
  def self.up
    create_table :shops do |t|
      t.string :first_name
      t.string :last_name
      t.string :domain
      t.boolean :sex
      t.date :birthdate

      t.timestamps
    end

		remove_column :users, :domain
		remove_column :users, :last_name
		remove_column :users, :first_name
		remove_column :users, :sex
		remove_column :users, :birthdate
		
		add_column :users, :shop_id, :integer
  end

  def self.down
    drop_table :shops
  end
end
