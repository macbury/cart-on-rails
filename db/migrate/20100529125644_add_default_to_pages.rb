class AddDefaultToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :default, :boolean
		Page.all.each do |page|
			page.default = true
			page.save
		end
  end

  def self.down
    remove_column :pages, :default
  end
end
