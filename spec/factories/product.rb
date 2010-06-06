Factory.define :good_product, :class => Product do |f|
  f.name "Koszulka Ruby on Rails"
	f.description "<p>test" 
end

Factory.define :dynamic_product, :class => Product do |f|
	f.sequence(:name) {|n| "Produkt #{n}" }
end

Factory.define :bad_product, :class => Product do |f|
  f.name ""
end