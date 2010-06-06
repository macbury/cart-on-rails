require File.dirname(__FILE__) + '/../spec_helper'
 
describe ProductPropetiesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "create action should render new template when model is invalid" do
    ProductPropeties.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ProductPropeties.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(product_propeties_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    product_propeties = ProductPropeties.first
    delete :destroy, :id => product_propeties
    response.should redirect_to(product_propeties_url)
    ProductPropeties.exists?(product_propeties.id).should be_false
  end
  
  it "update action should render edit template when model is invalid" do
    ProductPropeties.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ProductPropeties.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ProductPropeties.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ProductPropeties.first
    response.should redirect_to(product_propeties_url)
  end
end
