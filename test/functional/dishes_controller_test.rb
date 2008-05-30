require File.dirname(__FILE__) + '/../test_helper'
require 'dishes_controller'

# Re-raise errors caught by the controller.
class DishesController; def rescue_action(e) raise e end; end

class DishesControllerTest < Test::Unit::TestCase
  fixtures :dishes, :menus, :recipes

  def setup
    @controller = DishesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as(:quentin)
    @menu = Menu.find(:first)
  end

  def test_should_get_new
    get :new, :menu_id => 1
    assert_response :success
  end
  
  def test_should_create_dish
    old_count = Dish.count
    post :create, :dish => { :servings => 2 }, :recipe_id => 1, :menu_id => 1
    assert_equal old_count+1, Dish.count
    
    assert_redirected_to menu_path(assigns(:menu))
  end

  def test_should_get_edit
    get :edit, :id => 1, :menu_id => 1
    assert_response :success
  end
  
  def test_should_update_dish
    put :update, :menu_id => @menu.id, :id => @menu.dishes.first, :dish => {:servings => 5 }
    assert_redirected_to menu_path(assigns(:menu))
  end
  
  def test_should_destroy_dish
    old_count = Dish.count
    delete :destroy, :id => @menu.dishes.first, :menu_id => @menu
    assert_equal old_count-1, Dish.count
    
    assert_redirected_to menu_dishes_path
  end
end
