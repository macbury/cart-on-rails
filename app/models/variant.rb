class Variant < ActiveRecord::Base
	belongs_to :product
	
	has_and_belongs_to_many :option_values
	validates_presence_of :price
	validates_numericality_of :price
	validates_numericality_of :weight, :allow_blank => true
	validates_uniqueness_of :sku, :scope => :product_id, :allow_blank => true, :allow_nil => true
	
	named_scope :available, :conditions => {}
	
	before_save :update_option_values
	after_save :update_product_price_cache
	after_destroy :update_product_price_cache
	attr_accessor :options
	
	def available?
		true
	end
	
	def refresh_option_values
		stay = product.option_types.map(&:id)
		option_values.each do |option_value|
			option_values.delete(option_value) unless stay.include?(option_value.option_type_id)
		end
		
		if option_values.size == 0
			destroy
		else
			product.cache_price
		end
	end
	
	def update_option_values
		option_values.clear
		return if self.options.nil?
		valid_types = product.option_types.all(:conditions => ["name IN (?)", self.options.map {|k,v| k}])
		valid_values = OptionValue.all(:conditions => ["option_type_id IN (?) AND id IN (?)", valid_types.map(&:id), self.options.map { |k,v| v }])
		
		self.option_values += valid_values
	end
	
	def update_product_price_cache
		product.cache_price
		product.save
	end
	
end
