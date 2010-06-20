class PagesDrop < Radius::Drop

	register_object "page" do |tag|
		if @page
			return @page
		else
			"Nie można znaleźć strony: #{tag.attr['name']}"
		end
	end
	
end