class AddPresentationToOptionTypes < ActiveRecord::Migration
  def self.up
    add_column :option_types, :presentation, :string
  end

  def self.down
    remove_column :option_types, :presentation
  end
end
