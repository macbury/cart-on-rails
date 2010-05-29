class AddUserIdToTaggings < ActiveRecord::Migration
  def self.up
    add_column :taggings, :shop_id, :integer
  end

  def self.down
    remove_column :taggings, :shop_id
  end
end
