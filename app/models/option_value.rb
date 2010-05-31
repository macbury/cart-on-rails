class OptionValue < ActiveRecord::Base
	xss_terminate
	belongs_to :option_type
	
	validates_presence_of :name
	validates_uniqueness_of :name, :scope => :option_type_id
	
	attr_protected :option_type_id
end
