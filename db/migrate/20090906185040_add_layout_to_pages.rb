class AddLayoutToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :layout_id, :integer
  end

  def self.down
    remove_column :pages, :layout_id
  end
end
