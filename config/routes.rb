ActionController::Routing::Routes.draw do |map|

  map.with_options :name_prefix => 'admin_', :namespace => 'admin/', :subdomain => 'admin', :conditions => { :subdomain => 'admin' } do |admin|
    admin.resources :vendors
    admin.resources :categories
    admin.resources :products, :collection => { :suggest_tag => :any }
    admin.resources :pages
    admin.root :controller => "products", :action => 'index', :subdomain => 'admin'
  end
  
  map.resources :user_sessions
  map.login '/login', :controller => 'user_sessions', :action => 'new', :subdomain => 'admin'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy', :subdomain => 'admin'

  map.resources :users
  map.register '/register', :controller => 'users', :action => 'new'
  

  map.with_options :conditions => { :subdomain => /.+/ } do |shop|
    shop.root :controller => "products", :action => 'index'
    shop.resources :products
    shop.product "/:id", :controller => "products", :action => 'show'
  end
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  
  map.asset '/assets/:name.:format', :controller => 'photos', :action => 'fetch_asset'
  map.photo '/photos/:size/:id.:format', :controller => 'photos', :action => 'generate_photo'
  map.root :controller => "start", :subdomain => false
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
