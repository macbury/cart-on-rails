class OptionType < ActiveRecord::Base
	belongs_to :shop
	xss_terminate
	validates_presence_of :name, :presentation
	validates_uniqueness_of :name, :scope => :shop_id
	
	attr_protected :shop_id
	has_many :option_values, :dependent => :destroy
	has_and_belongs_to_many :prototypes
	has_and_belongs_to_many :products, :autosave => true
	
	before_save :format_name
	
	accepts_nested_attributes_for :option_values, :allow_destroy => true
	
	def format_name
		self.name = self.name.gsub(" ", "_").gsub(/[^a-z0-9_]+/i, '').downcase
	end
	
end
