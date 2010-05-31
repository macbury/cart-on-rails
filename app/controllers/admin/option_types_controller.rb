class Admin::OptionTypesController < ApplicationController
	tab :products
  layout 'admin'
	
	before_filter :login_required, :get_store_from_session
	filter_access_to [:create, :new]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @option_type = @shop.option_types.find(params[:id]) }
  # GET /admin_option_types
  # GET /admin_option_types.xml
  def index
    @option_types = @shop.option_types.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @option_types }
    end
  end

  # GET /admin_option_types/new
  # GET /admin_option_types/new.xml
  def new
    @option_type = OptionType.new
		3.times { @option_type.option_values.build }
  end

  # GET /admin_option_types/1/edit
  def edit
		render :action => "new"
  end

  # POST /admin_option_types
  # POST /admin_option_types.xml
  def create
		@option_type = @shop.option_types.new(params[:option_type])

    respond_to do |format|
      if @option_type.save
        flash[:notice] = 'OptionTypes was successfully created.'
        format.html { redirect_to(admin_option_types_path) }
        format.xml  { render :xml => @option_type, :status => :created, :location => @option_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @option_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_option_types/1
  # PUT /admin_option_types/1.xml
  def update

    respond_to do |format|
      if @option_type.update_attributes(params[:option_type])
        flash[:notice] = 'OptionTypes was successfully updated.'
        format.html { redirect_to(@option_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @option_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_option_types/1
  # DELETE /admin_option_types/1.xml
  def destroy
    @option_type.destroy

    respond_to do |format|
      format.html { redirect_to(admin_option_types_url) }
      format.xml  { head :ok }
    end
  end
end
