class ShopDrop < Radius::Drop
	
	# syntax <shop:title /> show current shop title
	#
	register_tag "title" do |tag|
		@shop.domain
	end
end
