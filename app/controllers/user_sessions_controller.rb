class UserSessionsController < ApplicationController
  tab :login
  title 'Logowanie'
  background true
  layout 'admin'
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Zalogowano w serwisie"
      redirect_to admin_products_path
    else
      flash[:error] = "Nieprawidłowy login lub hasło"
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    flash[:notice] = "Zostałeś wylogowany"
    redirect_to root_path(:subdomain => false)
  end
end
