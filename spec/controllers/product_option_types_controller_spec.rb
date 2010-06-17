require File.dirname(__FILE__) + '/../spec_helper'
 
describe ProductOptionTypesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "create action should render new template when model is invalid" do
    ProductOptionTypes.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ProductOptionTypes.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(product_option_types_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    product_option_types = ProductOptionTypes.first
    delete :destroy, :id => product_option_types
    response.should redirect_to(product_option_types_url)
    ProductOptionTypes.exists?(product_option_types.id).should be_false
  end
end
