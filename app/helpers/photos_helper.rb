module PhotosHelper
  
  def product_photo_url(photo, size="original")
    "/photos/#{size}/#{photo.id}.#{File.extname(photo.image_file_name).gsub('.', '')}"
    #photo_path(:size => size, :id => photo.id.to_s, :format => File.extname(photo.image_file_name).gsub('.', '')) 
  end
  
  def admin_product_photo_url(photo, size="original")
    unless photo.nil? || photo.new_record?
      product_photo_url(photo, size)
    else
      "/photos/original/missing.png"
    end
  end
  
  def product_photo_tag(photo, size="original")
    #if size =~ /([0-9]+)x([0-9]+)/i
    #  options = {
    #    :width => $1 + "px",
    #    :height => $2+ "px"
    #  }
    
    #else
      options = {}
    #end
    image_tag(product_photo_url(photo, size), options)
  end
  
end
