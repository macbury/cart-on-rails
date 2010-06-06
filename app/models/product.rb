class Product < ActiveRecord::Base
  xss_terminate :except => [:description]
  has_permalink :name, :update => true
  validates_presence_of :name
  validates_length_of :name, :within => 3..255
  validates_associated :photos
  
  is_taggable :tags
  
	radius_attr_accessible :name, :min_price, :max_price, :description
	
  has_many :photos, :dependent => :destroy, :order => 'position ASC'
  has_many :product_properties, :dependent => :destroy
	has_many :properties, :through => :product_properties, :order => "properties.name", :select => '"properties".*, product_properties.value AS value', :uniq => true

  belongs_to :shop
  belongs_to :theme

  attr_accessor :prototype_id
	after_create :apply_prototype
  #before_save :create_category_and_vendor
  #before_save :cache_price

  def main_photo
    photos.first
  end
	
	def photo
		main_photo
	end
	
	def to_param
		self.permalink
	end
	
	def create_properties_from_params!(raw_properties, raw_create_properties)
		self.product_properties.destroy_all
		
		unless raw_create_properties.nil?
			raw_create_properties.each do |raw_property|
				property = self.shop.properties.new(:name => raw_property[:name], :presentation => raw_property[:name].humanize)
				self.product_properties.create(:property_id => property.id, :value => raw_property[:value]) if property.save
			end
		end
		
		temp_properties = self.shop.properties.all(:conditions => ["properties.id IN (?)", raw_properties.map { |id,v| id }]).map(&:id)
		
		raw_properties.each do |property_id, value|
			next unless temp_properties.include?(property_id.to_i)
			self.product_properties.create(:property_id => property_id, :value => value)
		end
	end
	
	def description=(new_description)
		xml = Tidy.open(:show_warnings=>true) do |tidy|
			tidy.options.output_html = true
			tidy.options.merge_spans = true
			tidy.options.merge_divs = true
			tidy.options.ident = true
			tidy.options.join_classes = true
			tidy.options.hide_endtags = true
			tidy.options.enclose_text = true
			tidy.options.clean = true
			tidy.options.show_body_only = true
		  xml = tidy.clean(new_description)
		end
		write_attribute :description, xml
	end
	
  protected
    
		def apply_prototype
			return if self.prototype_id.nil?
			prototype = self.shop.prototypes.find(prototype_id)
			
			prototype.properties.each do |property|
				self.product_properties.create(:property_id => property.id, :value => "")
			end
		end

    def cache_price
      prices = versions.map(&:price)
      self.max_price = prices.max || 0
      self.min_price = prices.min || 0
    end
    
    def create_category_and_vendor
      self.category = Category.find_or_create_by_name_and_shop_id(@category_name.strip, self.shop_id) if self.category_id.nil? && (!@category_name.nil? || !@category_name.blank?)
      self.vendor = Vendor.find_or_create_by_name_and_shop_id(@vendor_name.strip, self.shop_id) if self.vendor_id.nil? && (!@vendor_name.nil? || !@vendor_name.blank?)
    end
end
