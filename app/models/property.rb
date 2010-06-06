class Property < ActiveRecord::Base
	has_many :product_properties, :dependent => :destroy
	has_many :products, :through => :product_properties
	belongs_to :shop
	has_and_belongs_to_many :prototype
	xss_terminate
	validates_presence_of :name, :presentation
	validates_uniqueness_of :name, :scope => :shop_id
	
	attr_protected :shop_id
	
	before_save :format_name
	
	def value
		read_attribute :value
	end
	
	def value=(val) end
	
	def format_name
		self.name = self.name.gsub(" ", "_").gsub(/[^a-z0-9_]+/i, '').downcase
	end
end
