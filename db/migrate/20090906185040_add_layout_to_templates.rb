class AddLayoutToTemplates < ActiveRecord::Migration
  def self.up
    add_column :themes, :layout_id, :integer
  end

  def self.down
    remove_column :themes, :layout_id
  end
end
