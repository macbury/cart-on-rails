class AssetDrop < Radius::Drop

	register_tag "img" do |tag|
		photo = tag.locals.photo rescue tag.missing!
		attributes = tag.attributes.clone
		
		size = attributes['size'] || 'original'
		attributes.delete('size')
		attributes[:alt] ||= tag.locals.product.name
		
		image_tag(photo.url, attributes)
	end
	
end