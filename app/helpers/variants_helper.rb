module VariantsHelper
	
	def option_type_for_variant(option_field, option_type, variant)
		selected_val = variant.option_values.find_by_option_type_id(option_type.id).id rescue 0
		
		option_field.input(option_type.name, :label => option_type.presentation, :collection => option_type.option_values, :as => :select, :include_blank => false, :selected => selected_val)
	end
	
end
