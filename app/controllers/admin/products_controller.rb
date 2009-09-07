class Admin::ProductsController < ApplicationController
  tab :products
  title 'Produkty'
  #background true, :only => [:new, :edit, :update, :create]
  layout 'admin'
  before_filter :login_required
  
  def suggest_tag
    @tags = Tag.all(:conditions => { :name.like => "%#{params[:q]}" })
    
    render :text => @tags.map(&:name).join("\n")
  end
  
  # GET /products
  # GET /products.xml
  def index
    @search = self.current_user.products.search(params[:search])
    @products = @search.paginate(:per_page => 5, :page => params[:page], :order => 'name ASC', :include => [:versions, :photos])
    
    @vendors = self.current_user.vendors.all(:order => 'name ASC')
    @categories = self.current_user.categories.all(:order => 'name ASC')
    
    respond_to do |format|
      format.html
      format.js
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

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
    @product = self.current_user.products.find(params[:id])
    render :action => "new"
  end

  # POST /products
  # POST /products.xml
  def create
    @product = self.current_user.products.new(params[:product])

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
    @product = self.current_user.products.find(params[:id])

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
    @product = self.current_user.products.find(params[:id])
    @product.destroy
    flash[:notice] = 'Produkt został usunięty!' 
    
    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
      format.xml  { head :ok }
    end
  end
end
