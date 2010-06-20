class ProductsController < ApplicationController
  before_filter :get_store

  def index
    @products = @shop.products.visible.all(:include => [:photos, :tags])
    @shop_title << "Strona główna"

    render_radius_template :collections, nil, { :products => @products }
  end
  
  def show
		begin
    	@product = @shop.products.visible.include_all.find_by_permalink!(params[:id])
			@product.properties.all
			@shop_title << @product.name
		rescue ActiveRecord::RecordNotFound
			render_radius_template '404', nil, {}
		else
			render_radius_template :product, @product.theme_id, { :product => @product }
		end

  end

	def qr_code
		@product = @shop.products.visible.include_all.find_by_permalink!(params[:id])
		
		redirect_to "http://chart.apis.google.com/chart?chs=300x300&cht=qr&chl=#{product_url(@product)}&choe=UTF-8"
	end
end
