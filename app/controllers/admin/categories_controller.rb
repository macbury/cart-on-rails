class Admin::CategoriesController < ApplicationController
  tab :products
  layout 'admin'
  background true, :except => [:index]
	before_filter :login_required, :get_store_from_session
	filter_resource_access
  
  def create
    @category = @shop.categories.new(params[:category])
    if @category.save
      flash[:notice] = "Dodano kategorię"
      redirect_to admin_products_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @category = @shop.categories.find(params[:id])
    @category.destroy
    flash[:notice] = "Usunięto kategorie."
    redirect_to admin_products_path
  end
  
  def edit
    @category = @shop.categories.find(params[:id])
  end
  
  def update
    @category = @shop.categories.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Zapisano zmiany w kategorii"
      redirect_to admin_products_path
    else
      render :action => 'edit'
    end
  end
end
