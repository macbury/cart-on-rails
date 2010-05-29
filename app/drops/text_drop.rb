class TextDrop < Radius::Drop
	include ActionView::Helpers::TextHelper
	include ActionView::Helpers::NumberHelper
	
	register_tag "currency" do |tag|
		number_to_currency(tag.expand, :separator => ",", :delimiter => " ", :unit => "") + ' zł'
	end
	
	register_tag "truncate" do |tag|
		length = tag['length'] || 255
		truncate(tag.expand, :length => length.to_i)
	end
	
	register_tag "textile" do |tag|
		RedCloth.new(tag.expand).to_html
	end
end