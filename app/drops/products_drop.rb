class ProductsDrop < Radius::Drop
	
	register_tag "product:vendors" do |variable|
		
	end
	
	# if there is no tags the content of tag is displied ex. <shop:product:tags> There is no tags! </shop:product:tags>
	# attribute separator: string that join tags default ", "
	
	register_tag "product:tags" do |tag|
		tag.locals.product rescue tag.missing!
		content = []
		
		attributes = tag.attributes.clone
		separator = attributes["separator"] || ", "
		attributes.delete("separator")
		
		tag.locals.product.tags.each do |product_tag|
			attributes[:href] = tag_path(product_tag)
			content << content_tag(:a, product_tag.name, attributes)
		end
		content = content.join(separator)
		
		content = tag.expand if tag.locals.product.tags.empty?
		
		content
	end
	
	# attributes: size describe size by this syntax widthXheight ex. 128x64
	# optional attribute crop.
	register_tag "product:photo" do |tag|
		photo = tag.locals.product.photo rescue tag.missing!
		
		attributes = tag.attributes.clone
		attributes.delete('size')
		attributes.delete('crop')
		attributes[:alt] ||= tag.locals.product.name
		
		if tag['size'] =~ PHOTO_SCALE_REGEXP
			width = $1
			height = $3
			crop = tag['crop'] =~ /true/i
			size = width.to_s
			size += crop ? "c" : "x"
			size += height.to_s
		else
			size = 'original'
		end
		
		image_tag("/photos/#{size}/#{photo.id}.#{File.extname(photo.image_file_name).gsub('.', '')}", attributes)
	end
	
end