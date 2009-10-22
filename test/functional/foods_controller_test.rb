require File.dirname(__FILE__) + '/../test_helper'
require 'foods_controller'

# Re-raise errors caught by the controller.
class FoodsController; def rescue_action(e) raise e end; end

class FoodsControllerTest < ActionController::TestCase
  fixtures :foods

  def setup
    @controller = FoodsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as(:quentin)
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:foods)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_food
    old_count = Food.count
    post :create, :food => {:name => "kidney beans",
                            :food_type => "dry",
                            :purchase_units => "lb",
                            :purchase_quantity => 1,
                            :purchase_price => 1 }
    assert_equal old_count+1, Food.count

    assert_redirected_to food_path(assigns(:food))
  end

  def test_should_show_food
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_food
    put :update, :id => 1, :food => { }
    assert_redirected_to food_path(assigns(:food))
  end

  def test_should_destroy_food
    old_count = Food.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Food.count

    assert_redirected_to food_path(1)
  end
end
