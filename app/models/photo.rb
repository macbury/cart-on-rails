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
    File.join([Rails.root,'public',self.url]).gsub(/(\?\d+)/, '')
  end
  
	def url
		image.url
	end
	
	def folder_name(width, height, crop=false)
		folder_name = "#{width}x#{height}"
		folder_name += "_crop" if crop
		folder_name
	end
	
	def folder_name_from_size(size,crop=nil)
		if size =~ PHOTO_SCALE_REGEXP
			folder_name($1, $3, crop)
		else
			"original"
		end
	end
	
	def self.size_from_string(size)
		if size =~ PHOTO_SCALE_REGEXP
			[$1.to_i, $3.to_i]
		else
			"original"
		end
	end
	
	def file_name
		id.to_s+File.extname(image_file_name)
	end
	
	def exists_for_size?(size, shop=nil, crop=nil)
		shop = product.shop unless shop
			File.exists?("#{Rails.root}/public/store_assets/#{shop.domain}/photos/#{folder_name_from_size(size, crop)}/#{file_name}")
	end
	
	def folder_path(width,height,crop=false)
		File.join([product.shop.public_folder_path, "/photos/", folder_name(width,height,crop)])
	end
	
	def generate_photo_for_size(width, height, crop=false)
    size = "#{width}x#{height}"
		size += crop ? '#' : '>'
		folder = folder_path(width,height,crop)
		file_path = File.join([folder, file_name])
		
		return if File.exists?(file_path)

		FileUtils.mkdir_p(folder) rescue nil
		
		thumb = Paperclip::Thumbnail.new(File.new(self.source), :geometry => size)
		tmp_thumb = thumb.make

		File.open(file_path, "a") do |file|
			tmp_thumb.rewind
			file.write tmp_thumb.read
		end
		tmp_thumb.close
		
		file_path
  end
	
end
