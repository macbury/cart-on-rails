Factory.define :good_prototype, :class => Prototype do |f|
	f.sequence(:name) {|n| "kubek #{n}" }
end

Factory.define :bad_prototype, :class => Prototype do |f|
	f.name ""
end
