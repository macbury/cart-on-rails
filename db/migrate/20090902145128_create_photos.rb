class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      
      t.string :image_file_name
      t.string :image_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      
      t.integer :product_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
