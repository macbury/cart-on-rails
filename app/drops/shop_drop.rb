class ShopDrop < Radius::Drop
	
	# syntax <shop:title /> show current shop title
	#
	register_tag "head" do |tag|
		head_content = content_tag(:title, @shop.title)
		head_content
		head_content
	end
end
