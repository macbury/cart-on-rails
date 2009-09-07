# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  helper_method :current_user_session, :current_user, :logged_in?
  
  protected

  def self.title(name, options = {})
    before_filter(options) do |controller|
      controller.instance_variable_set('@title', name)
    end
  end
  
  def self.tab(name, options = {})
    before_filter(options) do |controller|
      controller.instance_variable_set('@current_tab', name)
    end
  end
  
  def self.background(name, options = {})
    before_filter(options) do |controller|
      controller.instance_variable_set('@background', name)
    end
  end
  
  def current_user_session
    @current_user_session ||= UserSession.find
    return @current_user_session
  end
  
  def current_user
    @current_user ||= current_user_session && current_user_session.user
    return @current_user
  end

  def logged_in?
    !current_user.nil?
  end
  
  def store_location
    puts ">>>>>>>>>>>>>>>>> #{request.request_uri}"
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default
    redirect_to session[:return_to] || admin_products_path(:subdomain => 'admin')
    session[:return_to] = nil
  end
  
  def login_required
    unless logged_in?
      store_location
      flash[:error] = "Musisz się zalogować aby móc objrzeć tą strone"
      
      redirect_to login_path
    end
  end
  
  def get_store
    @shop = User.find_by_domain(current_subdomain)
  end
  
  def render_liquid_template(name, variables={})
    template = @shop.pages.find_by_page_type_and_name(1, name)
    
    if template.layout.nil?
      temp = Liquid::Template.parse(template.content)
    else
      variables['content_for_layout'] = Liquid::Template.parse(template.content).render(variables)
      temp = Liquid::Template.parse(template.layout.content)
    end
    
    render :text => temp.render(variables, [PhotosHelper, ProductsHelper, ActionView::Helpers::NumberHelper])
  end
  
end
