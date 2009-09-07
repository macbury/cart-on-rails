require 'test_helper'

class ShopsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Shop.first
    assert_template 'show'
  end
end
