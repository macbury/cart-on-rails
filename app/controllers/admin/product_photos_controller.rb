class Admin::ProductPhotosController < ApplicationController
	tab :photos
  layout 'admin'

	before_filter :login_required, :get_store_from_session, :preload_product
	filter_access_to [:create, :new, :positions]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @product_photo = @product.photos.find(params[:id]) }
	
  def index
    @product_photos = @product.photos.all
  end
  
  def create
    @product_photo = @product.photos.new(params[:photo])
    if @product_photo.save
			render :json => { :url => @product_photo.image.url(:thumb), :partial => render_to_string(:partial => "admin/product_photos/photo", :object => @product_photo) }
    else
      render :json => { :error => @product_photo.errors.full_messages.join(", ") }
    end
  end
  
  def destroy
    @product_photo.destroy

		respond_to do |format|
			format.html do 
				flash[:notice] = "Zdjęcie zostało usunięte!"
				redirect_to admin_product_photos_url(@product) 
			end
			format.js { render :nothing => true }
		end
  end
  
  def positions
    @product_photos = @product.photos.find(params[:photo])
    params[:photo].each_with_index do |photo_id, index|
    	@product_photos.each do |photo|
    		if photo.id == photo_id.to_i
    			photo.position = index
					photo.save
    		end
    	end
    end

		render :nothing => true
  end

end
