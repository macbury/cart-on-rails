class Category < ActiveRecord::Base
  belongs_to :user
  has_many :products, :dependent => :destroy
  
  xss_terminate
  has_permalink :name, :update => true
  validates_presence_of :name
  validates_length_of :name, :within => 3..255
  
  liquid_methods :name, :permalink
end
