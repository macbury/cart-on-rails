class PhotosController < ApplicationController

  def generate_photo
		photo = Photo.find(params[:id])
		shop = photo.product.shop
	
    file_path = "#{RAILS_ROOT}/public/store_assets/#{shop.domain}/photos/#{params[:size]}/#{params[:id]}.#{params[:format]}"

    if params[:size] =~ PHOTO_SCALE_REGEXP
			width = $1
			crop = $2
			height = $3
			
			size = "#{width}x#{height}"
			size += "#" if crop =~ /c/i
			
			Dir.mkdir(File.join([shop.public_folder_path, "/photos/#{params[:size]}/"])) rescue true
			#image = MiniMagick::Image.from_file(photo.source)
			#image.resize 
			#image.write(file_path)
			thumb = Paperclip::Thumbnail.new(File.new(photo.source), :geometry => size)
			tmp_thumb = thumb.make

			File.open(file_path, "a") do |file|
				tmp_thumb.rewind
				file.write tmp_thumb.read
			end
			tmp_thumb.close
		end

    send_file file_path
  end
  
end
