class AddDefaultToTemplates < ActiveRecord::Migration
  def self.up
    add_column :themes, :default, :boolean
  end

  def self.down
    remove_column :themes, :default
  end
end
