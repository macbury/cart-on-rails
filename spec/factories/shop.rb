Factory.define :scaffold_shop, :class => Shop do |f|
	f.first_name "Arkadiusz"
  f.last_name "Buras"
	f.sex true
	f.street "klonowa 25"
	f.city "Skarżyko-Kamienna"
	f.zip_code "26-110"
	f.phone "423684727"
	f.birthdate 19.years.ago.to_date	
	
	f.email "edek@pedek.pl"
	f.password "password"
	f.password_confirmation "password"
end

Factory.define :good_shop, :class => Shop, :parent => :scaffold_shop do |f|
  f.title "GeekGadgets"
	f.domain "geek-gadgets" 
end

Factory.define :test_shop, :class => Shop, :parent => :scaffold_shop do |f|
	f.sequence(:title) {|n| "GeekGadgets-#{n}" }
	f.sequence(:domain) {|n| "geek-gadgets-#{n}" }
end

Factory.define :bad_shop, :class => Shop do |f|
  f.title ""
	f.domain "$%@Zkiajslkd" 
	f.first_name ""
  f.last_name ""
	f.sex true
	f.street ""
	f.city ""
	f.zip_code "24566-135510"
	f.phone "4236847272334324"
	f.birthdate 2.years.ago.to_date	
	
	f.email "edeas"
	f.password "password_with_shit"
	f.password_confirmation ""
end
