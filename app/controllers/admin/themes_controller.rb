class Admin::ThemesController < ApplicationController
  tab :themes
  layout 'admin'
  background true, :except => [:index]
	before_filter :login_required, :get_store_from_session
	filter_resource_access

  def index
    @themes = @shop.themes.all(:order => 'page_type ASC')
  end

  # GET /admin_themes/new
  # GET /admin_themes/new.xml
  def new
    @page_template = @shop.themes.new
  end

  # GET /admin_themes/1/edit
  def edit
    @page_template = @shop.themes.find(params[:id])
    render :action => "new"
  end

  # POST /admin_themes
  # POST /admin_themes.xml
  def create
    @page_template = @shop.themes.new(params[:theme])

    if @page_template.save
      flash[:notice] = 'Dodano nowy szablon.'
			redirect_to admin_themes_path
    else
      render :action => "new" 
    end

  end

  # PUT /admin_themes/1
  # PUT /admin_themes/1.xml
  def update
    @page_template = @shop.themes.find(params[:id])

    if @page_template.update_attributes(params[:theme])
      flash[:notice] = 'Szablon został zapisany'
			render :action => "new"
    else
      render :action => "new"
    end
  end

  # DELETE /admin_themes/1
  # DELETE /admin_themes/1.xml
  def destroy
    @page_template = @shop.themes.find_by_id_and_default(params[:id], false)
    @page_template.destroy

    redirect_to admin_themes_path
  end
end
