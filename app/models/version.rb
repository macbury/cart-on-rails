class Version < ActiveRecord::Base
  xss_terminate
  belongs_to :product
  
  validates_presence_of :name
  attr_accessible :name, :price, :amount
  
  liquid_methods :name, :price, :amount
end
