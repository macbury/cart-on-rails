class Admin::CategoriesController < ApplicationController
  tab :products
  title 'Kategorie'
  layout 'admin'
  background true
  before_filter :login_required
  
  def create
    @category = self.current_user.categories.new(params[:category])
    if @category.save
      flash[:notice] = "Dodano kategorię"
      redirect_to admin_products_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @category = self.current_user.categories.find(params[:id])
    @category.destroy
    flash[:notice] = "Usunięto kategorie."
    redirect_to admin_products_path
  end
  
  def edit
    @category = self.current_user.categories.find(params[:id])
  end
  
  def update
    @category = self.current_user.categories.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Zapisano zmiany w kategorii"
      redirect_to admin_products_path
    else
      render :action => 'edit'
    end
  end
end
