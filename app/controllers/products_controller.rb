class ProductsController < ApplicationController
  before_filter :get_store
  layout :shop
  
  def index
    @products = @shop.products.all(:include => [:photos])
    
    render_liquid_template 'products', { 'products' => @products }
  end
  
  def show
    @product = @shop.products.find_by_permalink(params[:id])
    
    render_liquid_template 'product', { 'product' => @product }
  end
end
