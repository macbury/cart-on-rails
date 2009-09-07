class PhotosController < ApplicationController
  
  def generate_photo
    file_path = "#{RAILS_ROOT}/public/photos/#{params[:size]}/#{params[:id]}.#{params[:format]}"
    
    if File.exist?(file_path)
      send_file file_path
    else
      photo = Photo.find(params[:id])
      
      if params[:size] =~ /([0-9]+)x([0-9]+)/i
        width = $1
        height = $2
      end

      Dir.mkdir("#{RAILS_ROOT}/public/photos/#{params[:size]}/") rescue true
      image = MiniMagick::Image.from_file(photo.source)
      image.resize params[:size]
      image.write(file_path)
      
      send_file file_path
    end
  end
  
  def fetch_asset
    #file = "#{RAILS_ROOT}/public/store_assets/#{params[:subdomain]}/#{params[:name]}.#{params[:format]}"
    
    file = "#{RAILS_ROOT}/themes/vogue/assets/#{params[:subdomain]}/#{params[:name]}.#{params[:format]}"
    if File.exist?(file)
      send_file file
    else
      render :file => "#{RAILS_ROOT}/public/404.html" , :error => 404
    end 
  end
  
end
