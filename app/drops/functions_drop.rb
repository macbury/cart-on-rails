class FunctionsDrop < Radius::Drop
	register_tag "empty" do |tag|
		element = tag.attr['for'].clone
		
		if element =~ /([a-z_]+)/i
			element = $1.downcase
		end

		if element.nil?
			tag.missing!
		else
			obj = instance_variable_get('@'+element) || tag.locals.get(element)
			
			if obj.nil? || obj.empty?
				tag.expand
			end
		end
		
	end
end