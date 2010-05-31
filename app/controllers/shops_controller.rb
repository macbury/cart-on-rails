class ShopsController < ApplicationController
	tab :register
  background true

  layout 'admin'

  def index
    redirect_to admin_products_path
  end

  def new
    @shop = Shop.new
		@user = @shop.users.new
  end

  def create
    @shop = Shop.new(params[:shop])
		
    if @shop.save
			flash[:notice] = 'Sklep został utworzony'
			redirect_to admin_products_path
    else
      render :action => "new"
    end
  end

end
