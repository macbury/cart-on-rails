class Product < ActiveRecord::Base
  xss_terminate
  has_permalink :name, :update => true
  validates_presence_of :name, :description
  validates_length_of :name, :within => 3..255
  validates_associated :category, :vendor, :versions, :photos
  
  validate :has_one_version
  
  is_taggable :tags
  
  has_many :photos, :dependent => :destroy, :order => 'position ASC'
  has_many :versions, :dependent => :destroy, :order => 'price ASC'
  
  accepts_nested_attributes_for :versions, :allow_destroy => true, :reject_if => proc { |a| a['name'].blank? || a['price'].to_f == 0.0 }
  
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |a| a['image'].nil? }
  
  belongs_to :category
  belongs_to :user
  belongs_to :vendor
  
  attr_accessor :category_name, :vendor_name
  before_save :create_category_and_vendor
  before_save :cache_price
  
  liquid_methods :category, :main_photo, :name, :description, :vendor, :versions, :photos, :permalink, :max_price, :min_price
  
  def main_photo
    photos.first
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
      self.category = Category.find_or_create_by_name_and_user_id(@category_name.strip, self.user_id) if self.category_id.nil? && (!@category_name.nil? || !@category_name.blank?)
      self.vendor = Vendor.find_or_create_by_name_and_user_id(@vendor_name.strip, self.user_id) if self.vendor_id.nil? && (!@vendor_name.nil? || !@vendor_name.blank?)
    end
end
