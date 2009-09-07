class Photo < ActiveRecord::Base
  belongs_to :product
  
  xss_terminate
  has_attached_file :image, 
                    :url  => "/photos/original/:id.:extension",
                    :path => ":rails_root/public/photos/original/:id.:extension"

  validates_attachment_presence :image
  
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates_attachment_size :image, :less_than => 3.megabytes
  
  attr_accessible :image
  
  liquid_methods :url, :image_file_name, :id
  
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
