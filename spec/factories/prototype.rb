Factory.define :good_prototype, :class => Prototype do |f|
	f.name "test"
end

Factory.define :bad_prototype, :class => Prototype do |f|
	f.name ""
end