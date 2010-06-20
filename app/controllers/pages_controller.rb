class PagesController < ApplicationController
	before_filter :get_store
	
	def index
		render_radius_template :index, nil, { }
	end
end
