class ProductsDrop < Radius::Drop
	include ActionView::Helpers::NumberHelper
	include ActionView::Helpers::FormOptionsHelper
	include ActionView::Helpers::FormHelper
	
	register_tag "product:properties" do |tag|
		tag.locals.product rescue tag.missing!
		properties = tag.locals.product.properties
		
		content = ""
		
		properties.each do |property|
			tag.locals.property = property
			content += tag.expand
		end
		
		content
	end
	
	register_tag "property" do |tag|
		property = tag.locals.property rescue tag.missing!
		content = tag.expand
		
		if content.nil? || content.blank?
			content = "#{property.presentation}: #{property.value}"
		end
		
		content
	end
	
	register_tag "property:name" do |tag|
		property = tag.locals.property rescue tag.missing!
		property.presentation
	end
	
	register_tag "property:value" do |tag|
		property = tag.locals.property rescue tag.missing!
		property.value
	end
	
	# display product variants. 
	# type => "how should the be presented" [radio, select]
	# 		 =>  render select
	#			 =>  render radio
	register_tag "product:variants" do |tag|
		tag.locals.product rescue tag.missing!
		
		variants = tag.locals.product.variants
		
		attributes = tag.attributes.clone
		type = attributes["type"] || ""
		type = ["radio", "select"].include?(type.downcase) ? attributes["type"].downcase : false 
		attributes.delete("type")
		
		content = ""
		
		if type == "radio"
			variants.each_with_index do |variant, index|
				tag.locals.first = (index == 0)
				tag.locals.variant = variant
				content += tag.expand
			end
		elsif type="select"
			options = []
			variants.each do |variant|
				variant_name = variant.option_values.map { |option_value| "#{option_value.option_type.presentation}: #{option_value.name}" }.join(", ")
				variant_name += " - cena #{number_to_currency(variant.price)}"
				options << [variant_name, variant.id]
			end
			
			content = select("cart", "variant", options, { :include_blank => false }, attributes)
		else
			tag.locals.variants = variants
			tag.expand
		end
		
		content
	end
	
	register_tag "variant" do |tag|
		tag.expand
	end
	
	register_tag "variant:radio" do |tag|
		variant = tag.locals.variant rescue tag.missing!
		attributes = tag.attributes.clone
		attributes.delete("checked")
		attributes.delete("disabled")
		
		attributes[:checked] = (tag.locals.first)
		attributes[:disabled] = !variant.available?
		
		radio_button("cart", "variant", variant.id, attributes)
	end
	
	register_tag "variant:available" do |tag|
		variant = tag.locals.variant rescue tag.missing!
		tag.expand if variant.available?
	end
	
	register_tag "variant:unavailable" do |tag|
		variant = tag.locals.variant rescue tag.missing!
		tag.expand unless variant.available?
	end
	
	register_tag "variant:name" do |tag|
		variant = tag.locals.variant rescue tag.missing!
		
		attributes = tag.attributes.clone
		attributes.delete("for")
		
		variant_name = variant.option_values.map { |option_value| "#{option_value.option_type.presentation}: #{option_value.name}" }.join(", ")
		
		content_tag :label, variant_name, attributes.merge(:for => "cart_variant_#{variant.id}")
	end
	
	register_tag "variant:price" do |tag|
		variant = tag.locals.variant rescue tag.missing!
		number_to_currency(variant.price)
	end
	
	register_tag "product:vendors" do |variable|
		
	end
	
	# return current product formatted price 
	register_tag "product:price" do |tag|
		tag.locals.product rescue tag.missing!
		
		product = tag.locals.product
		
		if product.max_price.round == product.min_price.round
			number_to_currency(tag.locals.product.max_price)
		else
			'od '	+ number_to_currency(tag.locals.product.min_price) + ' do ' + number_to_currency(tag.locals.product.max_price)
		end
		
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
	
	register_tag "product:photos" do |tag|
		tag.locals.product rescue tag.missing!
		photos = tag.locals.product.photos
		
		content = ""
		
		photos.each do |photo|
			tag.locals.photo = photo
			content += tag.expand
		end
		
		content
	end
	
	# attributes: size describe size by this syntax widthXheight ex. 128x64
	# optional attribute crop.
	register_tag "photo" do |tag|
		tag.missing! if tag.locals.photo.nil? || tag.locals.product.nil?
		photo = tag.locals.photo || tag.locals.product.photo
		product = tag.locals.product
		
		attributes = tag.attributes.clone
		link = attributes['link'] =~ /true/i
		size = attributes['size'] || 'original'
		crop = attributes['crop'] =~ /true/i
		attributes['alt'] ||= product.name if product
		attributes.delete('crop')
		attributes.delete('link')
		attributes.delete('size')
		
		unless (size =~ /original/i || photo.exists_for_size?(size, @shop, crop))
			url = "/images/generating-preview.gif"
			width, height = photo.size_from_string(size)
			attributes['width'] = width
			attributes['height'] = height
			Delayed::Job.enqueue(PhotoJob.new({
				:width => width,
				:height => height,
				:crop => crop,
				:id => photo.id
			}))
		else
			url = "/photos/#{photo.folder_name_from_size(size,crop)}/#{photo.file_name}"
		end
		
		content = image_tag(url, attributes)
		
		if link
			attributes[:href] = "/photos/original/#{photo.file_name}"
			content = content_tag(:a, content, attributes) 
		end
		
		content
	end
	
end