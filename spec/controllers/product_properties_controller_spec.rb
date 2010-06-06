require File.dirname(__FILE__) + '/../spec_helper'
 
describe ProductPropertiesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "create action should render new template when model is invalid" do
    ProductProperties.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ProductProperties.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(product_properties_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    product_properties = ProductProperties.first
    delete :destroy, :id => product_properties
    response.should redirect_to(product_properties_url)
    ProductProperties.exists?(product_properties.id).should be_false
  end
  
  it "update action should render edit template when model is invalid" do
    ProductProperties.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ProductProperties.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    ProductProperties.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ProductProperties.first
    response.should redirect_to(product_properties_url)
  end
end
