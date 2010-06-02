class Admin::ProductPhotosController < ApplicationController
	tab :products
  layout 'admin'

	before_filter :login_required, :get_store_from_session, :preload_product
	filter_access_to [:create, :new]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @product_photo = @product.photos.find_by_permalink!(params[:id]) }
	
  def index
    @product_photos = @product.photos.all
		@product_photos << @product.photos.build if @product_photos.empty?
  end
  
  def create
    @product_photos = ProductPhotos.new(params[:product_photos])
    if @product_photos.save
      flash[:notice] = "Successfully created product photos."
      redirect_to product_photos_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @product_photos = ProductPhotos.find(params[:id])
    @product_photos.destroy
    flash[:notice] = "Successfully destroyed product photos."
    redirect_to product_photos_url
  end
  
  def update
    @product_photos = ProductPhotos.find(params[:id])
    if @product_photos.update_attributes(params[:product_photos])
      flash[:notice] = "Successfully updated product photos."
      redirect_to product_photos_url
    else
      render :action => 'edit'
    end
  end

	protected 
		
		def preload_product
			@product = @shop.products.find_by_permalink!(params[:product_id])
		end
end
