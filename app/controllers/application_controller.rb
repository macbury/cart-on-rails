# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation, :email, :first_name, :last_name, :birthdate
  
  helper_method :current_user_session, :current_user, :logged_in?
  
	before_filter { |c| Authorization.current_user = c.current_user }
	before_filter :set_cookie_domain
	
	def set_cookie_domain
		cookies[:key] = {
			:expires => 7.year.from_now,
			:domain => '.shop.local'
		}
	end
	
	# return current logged user
  def current_user
    @current_user ||= self.current_user_session && self.current_user_session.user
    return @current_user
  end

  protected
  
	def admin_domain_required
		redirect_to :subdomain => "admin" unless current_subdomain =~ /admin/i
	end

	def current_user_session
    @current_user_session ||= UserSession.find
    return @current_user_session
  end

	def permission_denied
	  flash[:error] = "Sorry, you are not allowed to access that page."
	  redirect_to login_path
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

  def logged_in?
    !current_user.nil?
  end
  
  def store_location
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
    @shop = Shop.find_by_domain!(current_subdomain)
  end
  
	def get_store_from_session
		@shop = self.current_user.shop
	end

  def render_radius_template(name, variables={})
		template = @shop.themes.find_by_page_type_and_name(Theme.type_index('Page'), name)

		standard_variables = { 
			:shop => @shop,
			:title => @shop.title
		}
		standard_variables.merge!(variables)

    parser = Radius::Template.new(standard_variables, [FunctionsDrop, ShopDrop, AssetDrop, TextDrop, ProductsDrop])
		
		parser.define_tag 'snippet' do |tag|
			snippet_name = tag['name']
			
			snippet = @shop.themes.find_by_page_type_and_name(Theme.type_index('Snippet'), snippet_name)
			
			if snippet_name.nil? || snippet.nil?
				"<strong>Error:</strong> undefined snippet '#{tag['name']}'"
			else
				parser.parse(snippet.content)
			end
		end
		
		out = parser.parse(template.content)
		
		unless template.layout.nil?
			standard_variables[:content] = out
			parser.locals = standard_variables
			
			out = parser.parse(template.layout.content)
		end
    
    render :text => out
  end
  
end
