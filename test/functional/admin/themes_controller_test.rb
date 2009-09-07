require 'test_helper'

class Admin::ThemesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_themes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create theme" do
    assert_difference('Admin::Theme.count') do
      post :create, :theme => { }
    end

    assert_redirected_to theme_path(assigns(:theme))
  end

  test "should show theme" do
    get :show, :id => admin_themes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_themes(:one).to_param
    assert_response :success
  end

  test "should update theme" do
    put :update, :id => admin_themes(:one).to_param, :theme => { }
    assert_redirected_to theme_path(assigns(:theme))
  end

  test "should destroy theme" do
    assert_difference('Admin::Theme.count', -1) do
      delete :destroy, :id => admin_themes(:one).to_param
    end

    assert_redirected_to admin_themes_path
  end
end
