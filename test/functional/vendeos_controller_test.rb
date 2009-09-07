require 'test_helper'

class VendeosControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Vendeo.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Vendeo.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Vendeo.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to vendeo_url(assigns(:vendeo))
  end
  
  def test_edit
    get :edit, :id => Vendeo.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Vendeo.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Vendeo.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Vendeo.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Vendeo.first
    assert_redirected_to vendeo_url(assigns(:vendeo))
  end
  
  def test_destroy
    vendeo = Vendeo.first
    delete :destroy, :id => vendeo
    assert_redirected_to vendeos_url
    assert !Vendeo.exists?(vendeo.id)
  end
end
