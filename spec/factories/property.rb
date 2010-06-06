Factory.define :good_property, :class => Property do |f|
	f.presentation "Typ matrycy"
	f.name "Typ matrycy"
end

Factory.define :dynamic_property, :class => Property do |f|
	f.sequence(:name) {|n| "property #{n}" }
	f.sequence(:presentation) {|n| "property #{n}" }
end

Factory.define :bad_property, :class => Property do |f|
	f.name ""
	f.presentation ""
end