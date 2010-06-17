class PhotoJob < Struct.new(:options)
  def perform
		photo = Photo.find(options[:id])
		photo.generate_photo_for_size(options[:width], options[:height], options[:crop])
  end
end