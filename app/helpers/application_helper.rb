# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tab_for(tab, name, link)
    link_to name, link, :class => @current_tab == tab ? 'selected' : 'normal'
  end
  
  def error_for(object, name)
    out = ""
    errors = object.errors.on(name)
    
    unless errors.nil?
      msg = errors.class == Array ? errors.join(', ') : errors
      out += content_tag :span, " - #{msg}", :class => 'validation_error'
    end
    
    return out
  end
  
  def render_flash
    out = ""
    flash.each do |type, msg|
      out += content_tag :div, msg, :class => type
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
