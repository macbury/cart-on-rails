class Admin::VariantsController < ApplicationController
	tab :variants
  layout 'admin'

	before_filter :login_required, :get_store_from_session, :preload_product
	filter_access_to [:create, :new, :positions]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @variant = @product.variants.find(params[:id]) }
  # GET /variants
  # GET /variants.xml
  def index
    @variants = @product.variants.all(:include => {:option_values => :option_type})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @variants }
    end
  end

  # GET /variants/new
  # GET /variants/new.xml
  def new
    @variant = Variant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @variant }
    end
  end

  # GET /variants/1/edit
  def edit
		render :action => "new"
  end

  # POST /variants
  # POST /variants.xml
  def create
		@variant = @product.variants.new(params[:variant])
    respond_to do |format|
      if @variant.save
        flash[:notice] = 'Variant was successfully created.'
        format.html { redirect_to(admin_product_variants_path(@product)) }
        format.xml  { render :xml => @variant, :status => :created, :location => @variant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @variant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /variants/1
  # PUT /variants/1.xml
  def update
    respond_to do |format|
      if @variant.update_attributes(params[:variant])
        flash[:notice] = 'Variant was successfully updated.'
        format.html { redirect_to(admin_product_variants_path(@product)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @variant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /variants/1
  # DELETE /variants/1.xml
  def destroy
    @variant.destroy

    respond_to do |format|
      format.html { redirect_to(admin_product_variants_path(@product)) }
      format.xml  { head :ok }
    end
  end
end
