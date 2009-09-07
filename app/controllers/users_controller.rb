class UsersController < ApplicationController
  tab :register
  title 'Rejestracja'
  background true
  layout 'admin'
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created user."
      redirect_to admin_products_path
    else
      flash[:error] = "Nieprawidłowe dane"
      render :action => 'new'
    end
  end

end
