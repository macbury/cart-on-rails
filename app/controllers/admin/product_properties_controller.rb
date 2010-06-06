class Admin::ProductPropertiesController < ApplicationController
	tab :properties
  layout 'admin'

	before_filter :login_required, :get_store_from_session, :preload_product
	filter_access_to [:create, :index]

  def index
		@properties = @product.properties
		@select_properties = @shop.properties.all(:conditions => @properties.size == 0 ? nil : ["properties.id NOT IN (?)", @properties.map(&:id)])
		
  end
  
  def create
		@product.create_properties_from_params!(params[:property], params[:create_property])
		
		flash[:notice] = "Zapisano szczegóły dla produktu"
    redirect_to admin_product_properties_url(@product)
  end

end
