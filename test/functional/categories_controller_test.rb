require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def test_create_invalid
    Category.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Category.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    category = Category.first
    delete :destroy, :id => category
    assert_redirected_to root_url
    assert !Category.exists?(category.id)
  end
  
  def test_edit
    get :edit, :id => Category.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Category.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Category.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Category.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Category.first
    assert_redirected_to root_url
  end
end
