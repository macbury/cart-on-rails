class Admin::DashboardController < ApplicationController
  layout 'admin'
	
	before_filter :login_required, :get_store_from_session
	filter_access_to [:index]
end
