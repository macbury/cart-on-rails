class ProductsController < ApplicationController
  before_filter :get_store

  def index
    @products = @shop.products.all(:include => [:photos, :tags])
    
    render_radius_template 'products', { :products => @products }
  end
  
  def show
		begin
    	@product = @shop.products.find_by_permalink!(params[:id])
		rescue ActiveRecord::RecordNotFound
			render_radius_template '404', {}
		else
			render_radius_template 'product', { :product => @product }
		end

  end
end
