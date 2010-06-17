class ProductsController < ApplicationController
  before_filter :get_store

  def index
    @products = @shop.products.visible.all(:include => [:photos, :tags])
    
    render_radius_template :collections, nil, { :products => @products }
  end
  
  def show
		begin
    	@product = @shop.products.visible.include_all.find_by_permalink!(params[:id])
			@product.properties.all
		rescue ActiveRecord::RecordNotFound
			render_radius_template '404', nil, {}
		else
			render_radius_template :product, @product.theme_id, { :product => @product }
		end

  end
end
