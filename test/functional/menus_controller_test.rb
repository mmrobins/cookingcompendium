require File.dirname(__FILE__) + '/../test_helper'
require 'menus_controller'

# Re-raise errors caught by the controller.
class MenusController; def rescue_action(e) raise e end; end

class MenusControllerTest < ActionController::TestCase
  fixtures :menus

  def setup
    @controller = MenusController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as(:quentin)
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:menus)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_menu
    old_count = Menu.count
    post :create, :menu => {:name => "Winter Seasonal" }
    assert_equal old_count+1, Menu.count

    assert_redirected_to menu_path(assigns(:menu))
  end

  def test_should_show_menu
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_menu
    put :update, :id => 1, :menu => { }
    assert_redirected_to menu_path(assigns(:menu))
  end

  def test_should_destroy_menu
    old_count = Menu.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Menu.count

    assert_redirected_to menus_path
  end
end
