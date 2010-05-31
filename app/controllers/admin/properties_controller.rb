class Admin::PropertiesController < ApplicationController
	tab :products
  layout 'admin'
	
	before_filter :login_required, :get_store_from_session
	filter_access_to [:create, :new]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @property = @shop.properties.find(params[:id]) }

  # GET /properties
  # GET /properties.xml
  def index
    @properties = @shop.properties.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end


  # GET /properties/new
  # GET /properties/new.xml
  def new
    @property = @shop.properties.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/1/edit
  def edit

  end

  # POST /properties
  # POST /properties.xml
  def create
    @property = @shop.properties.new(params[:property])

    respond_to do |format|
      if @property.save
        flash[:notice] = 'Property was successfully created.'
        format.html { redirect_to admin_properties_path }
        format.xml  { render :xml => @property, :status => :created, :location => @property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.xml
  def update

    respond_to do |format|
      if @property.update_attributes(params[:property])
        flash[:notice] = 'Property was successfully updated.'
        format.html { redirect_to(@property) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.xml
  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to(properties_url) }
      format.xml  { head :ok }
    end
  end
end
