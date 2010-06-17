Factory.define :good_option_type, :class => OptionType do |f|
	f.presentation "Kolor ramki"
	f.name "Kolor ramki"
end

Factory.define :dynamic_option_type, :class => OptionType do |f|
	f.sequence(:presentation) {|n| "Test #{n}" }
	f.sequence(:name) {|n| "Test #{n}" }
end

Factory.define :bad_option_type, :class => OptionType do |f|
	f.presentation ""
	f.name ""
end

Factory.define :good_option_value, :class => OptionValue do |f|
	f.name "Czarny"
end

Factory.define :bad_option_value, :class => OptionValue do |f|
	f.name ""
end