require File.dirname(__FILE__) + '/../spec_helper'
 
describe ProductPhotosController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "create action should render new template when model is invalid" do
    ProductPhotos.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ProductPhotos.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(product_photos_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    product_photos = ProductPhotos.first
    delete :destroy, :id => product_photos
    response.should redirect_to(product_photos_url)
    ProductPhotos.exists?(product_photos.id).should be_false
  end
  
  it "update action should render edit template when model is invalid" do
    ProductPhotos.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ProductPhotos.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ProductPhotos.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ProductPhotos.first
    response.should redirect_to(product_photos_url)
  end
end
