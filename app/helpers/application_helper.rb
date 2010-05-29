# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tab_for(tab, name, link)
    link_to name, link, :class => @current_tab == tab ? 'selected' : 'normal'
  end
  
	def inline_errors(object, attribute)
		errors = object.errors.on(attribute)
		
		content_tag :p, errors.class == Array ? errors.join(', ') : errors, :class => 'inline-errors' unless errors.nil?
	end
  
  def render_flash
    out = ""
    flash.each do |type, msg|
      out += content_tag :div, msg, :class => "flash_#{type}"
    end
    flash.discard
    return out
  end
  
  def title
    title = "Cart On Rails"
    title += " - #{@title}" unless @title.nil?
    return title
  end
end
