class Admin::PrototypesController < ApplicationController
	tab :prototypes
  layout 'admin'
	
	before_filter :login_required, :get_store_from_session
	filter_access_to [:create, :new]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @prototype = @shop.prototypes.find(params[:id]) }
  # GET /prototypes
  # GET /prototypes.xml
  def index
    @prototypes = @shop.prototypes.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prototypes }
    end
  end

  # GET /prototypes/new
  # GET /prototypes/new.xml
  def new
    @prototype = @shop.prototypes.new
		
		
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prototype }
    end
  end

  # GET /prototypes/1/edit
  def edit
		render :action => "new"
  end

  # POST /prototypes
  # POST /prototypes.xml
  def create
    @prototype = @shop.prototypes.new(params[:prototype])

    respond_to do |format|
      if @prototype.save
        flash[:notice] = 'Prototype was successfully created.'
        format.html { redirect_to([:admin, @prototype]) }
        format.xml  { render :xml => @prototype, :status => :created, :location => @prototype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prototype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prototypes/1
  # PUT /prototypes/1.xml
  def update
    @prototype = Prototype.find(params[:id])

    respond_to do |format|
      if @prototype.update_attributes(params[:prototype])
        flash[:notice] = 'Prototype was successfully updated.'
        format.html { redirect_to(@prototype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prototype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prototypes/1
  # DELETE /prototypes/1.xml
  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy

    respond_to do |format|
      format.html { redirect_to(admin_prototypes_url) }
      format.xml  { head :ok }
    end
  end
end
