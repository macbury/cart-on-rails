class AddTypeToTemplates < ActiveRecord::Migration
  def self.up
    add_column :themes, :page_type, :integer
  end

  def self.down
    remove_column :themes, :page_type
  end
end
