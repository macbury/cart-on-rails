class CreateShops < ActiveRecord::Migration
  def self.up
    create_table :shops do |t|
			t.string :domain
			t.string :title
      
			t.string :street
			t.string :city
			t.string :zip_code
			t.string :phone

			t.string :first_name
      t.string :last_name
      t.boolean :sex
      t.date :birthdate

      t.timestamps
    end

		add_column :users, :shop_id, :integer
  end

  def self.down
    drop_table :shops
  end
end
