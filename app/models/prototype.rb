class Prototype < ActiveRecord::Base
	xss_terminate
	belongs_to :shop
	validates_presence_of :name
	validates_uniqueness_of :name, :scope => :shop_id
	
	attr_protected :shop_id
	
	has_and_belongs_to_many :option_types, :autosave => true
	has_and_belongs_to_many :properties, :autosave => true
end
