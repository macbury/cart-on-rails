class Property < ActiveRecord::Base
	belongs_to :shop
	xss_terminate
	validates_presence_of :name, :presentation
	validates_uniqueness_of :name, :scope => :shop_id
	
	attr_protected :shop_id

	before_save :format_name
	
	def format_name
		self.name = self.name.gsub(" ", "_").gsub(/[^a-z0-9_]+/i, '').downcase
	end
end
