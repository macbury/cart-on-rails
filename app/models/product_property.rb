class ProductProperty < ActiveRecord::Base
	xss_terminate
	belongs_to :product
	belongs_to :property
	validates_length_of :value, :within => 0..255
end
