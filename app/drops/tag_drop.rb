class TagDrop < Radius::Drop
	include ActionView::Helpers::TextHelper
	
	# cycle throught classes and wrap them in the presented tag
	# wrap => "li"
	# through => "odd, even"
	register_tag "cycle" do |tag|
		attributes = tag.attributes.clone
		
		klasses = attributes['through'] || "odd, even"
		klasses = klasses.split(",")
		main_klass = attributes["class"] || ""
		attributes.delete("class")
		attributes.delete("through")
		
		wrapper = attributes["wrap"] || "li"
		attributes.delete("wrap")
		
		content_tag wrapper, tag.expand, attributes.merge({:class => "#{main_klass} #{cycle(*klasses)}"})
	end
	
	#output content for head tag like title description
	register_tag "head" do |tag|
		out = <<-HTML
			<title>#{@shop_title.join(" - ")}</title>
			<meta name="keywords" content="Sklep internetowy, oprogramowanie sklepu, otwórz własny sklep internetowy" />
			<meta name="description" content="Dzięki oprogramowaniu shoper.pl możesz bardzo szybko rozpocząć sprzedaż w internecie. Shoper.pl - Numer 1 w POLSCE! Najwięcej sprzedanych licencji." />
		HTML
		
		out
	end
end
