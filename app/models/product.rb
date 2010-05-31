class Product < ActiveRecord::Base
  xss_terminate
  has_permalink :name, :update => true
  validates_presence_of :name, :description
  validates_length_of :name, :within => 3..255
  validates_associated :photos
  
  validate :has_one_version
  
  is_taggable :tags
  
	radius_attr_accessible :name, :min_price, :max_price, :description
	
  has_many :photos, :dependent => :destroy, :order => 'position ASC'
  
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |a| a['image'].nil? }
  
  belongs_to :shop
  
  #attr_accessor :category_name, :vendor_name
  #before_save :create_category_and_vendor
  before_save :cache_price

  def main_photo
    photos.first
  end
	
	def photo
		main_photo
	end
	
	def to_param
		self.permalink
	end

  protected
    
    def has_one_version
      errors.add :versions, 'musi być przynajmniej jedna wersja produktu' if versions.size == 0
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
