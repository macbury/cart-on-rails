module SidebarsHelper
	
	def sidebar_item_for(id, name, link)
		content_tag :li, link_to(name, link), :class => @current_tab == id ? "active" : nil
	end
	
	def sidebar_for_products
		out = []
		out << sidebar_item_for(:products, "Produkty", admin_products_path)
		out << sidebar_item_for(:prototypes, "Szablon", admin_prototypes_path)
		out << sidebar_item_for(:properties, "Szczegóły", admin_properties_path)
		out << sidebar_item_for(:option_types, "Atrybuty", admin_option_types_path)
		
		out.join("\n")
	end
	
end