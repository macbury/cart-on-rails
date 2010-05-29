class Admin::ProductsController < ApplicationController
  tab :products
  layout 'admin'
	
	before_filter :login_required, :get_store_from_session
	filter_access_to [:create, :new, :suggest_tag]
  filter_access_to [:show, :edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @product = @shop.products.find_by_permalink!(params[:id]) }
  
  def suggest_tag
    @tags = Tag.all(:conditions => { :name.like => "%#{params[:q]}" })
    
    render :text => @tags.map(&:name).join("\n")
  end
  
  # GET /products
  # GET /products.xml
  def index
    @search = @shop.products.search(params[:search])
    @products = @search.paginate(:per_page => 5, :page => params[:page], :order => 'name ASC', :include => [:versions, :photos])
    
    @vendors = @shop.vendors.all(:order => 'name ASC')
    @categories = @shop.categories.all(:order => 'name ASC')
    
    respond_to do |format|
      format.html
      format.js
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @product.versions.build
    @product.photos.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    render :action => "new"
  end

  # POST /products
  # POST /products.xml
  def create
    @product = @shop.products.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Produkt został dodany!'
        format.html { redirect_to admin_products_path }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Produkt został zapisany!'
        format.html { redirect_to admin_products_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy

    @product.destroy
    flash[:notice] = 'Produkt został usunięty!' 
    
    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
      format.xml  { head :ok }
    end
  end
end
