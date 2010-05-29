Factory.define :good_shop, :class => Shop do |f|
  f.title "GeekGadgets"
	f.domain "gadzety" 
	f.first_name "Arkadiusz"
  f.last_name "Buras"
	f.sex true
	f.street "klonowa 25"
	f.city "Skarżyko-Kamienna"
	f.zip_code "26-110"
	f.phone "423684727"
	f.birthdate 19.years.ago.to_date	
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
end
