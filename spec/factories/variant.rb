Factory.define :good_variant, :class => Variant do |f|
	f.price "20.00"
	f.weight "300"
	f.sku "ROR-001"
	f.product {|product| product.association(:good_product) }
end

Factory.define :bad_variant, :class => Variant do |f|
	f.price ""
	f.weight "asjnnjdjkl"
	f.sku "ROR-001"
	f.product {|product| product.association(:good_product) }
end