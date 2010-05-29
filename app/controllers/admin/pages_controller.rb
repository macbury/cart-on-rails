class Admin::PagesController < ApplicationController
  tab :pages
  layout 'admin'
  background true, :except => [:index]
	before_filter :login_required, :get_store_from_session
	filter_resource_access

  def index
    @pages = @shop.pages.all(:order => 'page_type ASC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /admin_themes/1
  # GET /admin_themes/1.xml
  def show
    @page = @shop.pages.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /admin_themes/new
  # GET /admin_themes/new.xml
  def new
    @page = @shop.pages.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /admin_themes/1/edit
  def edit
    @page = @shop.pages.find(params[:id])
    render :action => "new"
  end

  # POST /admin_themes
  # POST /admin_themes.xml
  def create
    @page = @shop.pages.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Dodano nowy szablon.'
        format.html { redirect_to admin_pages_path }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_themes/1
  # PUT /admin_themes/1.xml
  def update
    @page = @shop.pages.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Szablon został zapisany'
        format.html { redirect_to admin_pages_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_themes/1
  # DELETE /admin_themes/1.xml
  def destroy
    @page = @shop.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to admin_pages_path }
      format.xml  { head :ok }
    end
  end
end
