class AddTypeToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_type, :integer
  end

  def self.down
    remove_column :pages, :page_type
  end
end
