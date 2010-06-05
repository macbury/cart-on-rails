PHOTO_SCALE_REGEXP = /(\d{1,5})([xc])(\d{1,5})/i
Paperclip.interpolates :domain do |attachment, style|
  attachment.instance.product.shop.domain
end

class Photo < ActiveRecord::Base
  belongs_to :product

  xss_terminate
  has_attached_file :image, 
                    :url  => "/store_assets/:domain/photos/:style/:id.:extension",
                    :path => ":rails_root/public/store_assets/:domain/photos/:style/:id.:extension",
										:styles => { :thumb => "100x100#", :preview => "640x480>" }

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates_attachment_size :image, :less_than => 3.megabytes
  
  attr_accessible :image
  
	def to_radius
		[:url]
	end

  def url
    image.url
  end
  
  def name
    image_file_name || 'Brak'
  end
  
  def source
    RAILS_ROOT + '/public' + self.url
  end
  
end
