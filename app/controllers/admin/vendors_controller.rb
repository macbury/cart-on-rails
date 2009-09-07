class Admin::VendorsController < ApplicationController
  tab :products
  title 'Kategorie'
  layout 'admin'
  background true
  before_filter :login_required
  
  def create
    @vendor = self.current_user.vendors.new(params[:vendor])
    if @vendor.save
      flash[:notice] = "Dodano producenta"
      redirect_to @vendor
    else
      render :action => 'edit'
    end
  end
  
  def edit
    @vendor = self.current_user.vendors.find(params[:id])
  end
  
  def update
    @vendor = self.current_user.vendors.find(params[:id])
    if @vendor.update_attributes(params[:vendor])
      redirect_to admin_products_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @vendor =self.current_user.vendors.find(params[:id])
    @vendor.destroy
    flash[:notice] = "Usunięto producenta"
    redirect_to admin_products_path
  end
end
