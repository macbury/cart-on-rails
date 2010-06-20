ActionController::Routing::Routes.draw do |map|
  map.with_options :name_prefix => 'admin_', :namespace => 'admin/', :subdomain => 'admin', :conditions => { :subdomain => 'admin' } do |admin|
    admin.resources :products, :collection => { :suggest_tag => :any }, :member => { :option_types => :get } do |product|
    	product.resources :photos, :collection => { :positions => :post }, :controller => "product_photos"
			product.resources :properties, :controller => "product_properties"
			product.resources :variants
    end
    admin.resources :themes
		admin.resources :properties
		admin.resources :prototypes
		admin.resources :option_types
    admin.root :controller => "dashboard", :action => 'index', :subdomain => 'admin'
  end
  
  map.resources :user_sessions
  map.login '/login', :controller => 'user_sessions', :action => 'new', :subdomain => 'admin'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy', :subdomain => 'admin'

  map.resources :users
  
	map.resources :shops
	map.register '/register', :controller => 'shops', :action => 'new'
  
  map.with_options :conditions => { :subdomain => /.+/ } do |shop|
    shop.root :controller => "pages", :action => 'index'
    #shop.product "/:id", :controller => "products", :action => 'show'
		shop.resources :products, :member => { :qr_code => :get }
		shop.resources :tags
  end
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  
  map.root :controller => "start", :subdomain => false
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
