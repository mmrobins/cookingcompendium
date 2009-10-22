require File.dirname(__FILE__) + '/../test_helper'
require 'food_conversions_controller'

# Re-raise errors caught by the controller.
class FoodConversionsController; def rescue_action(e) raise e end; end

class FoodConversionsControllerTest < ActionController::TestCase
  fixtures :food_conversions, :foods

  def setup
    @controller = FoodConversionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @food_conversion = FoodConversion.find(:first)
    login_as(:quentin)
  end

  def test_should_get_new
    get :new, :food_id => 1
    assert_response :success
  end

  def test_should_create_food_conversion
    old_count = FoodConversion.count
    post :create, :food_conversion => {:conversion_quantity => 1,
                             :conversion_units => "lbs",
                             :equivalent_units => "l",
                             :equivalent_quantity => 2}, :food_id => 1
    assert_equal old_count+1, FoodConversion.count
    assert_redirected_to food_path(1)
  end

  def test_should_destroy_food_conversion
    old_count = FoodConversion.count
    delete :destroy, :id => @food_conversion.id, :food_id => @food_conversion.food_id
    assert_equal old_count-1, FoodConversion.count

    assert_redirected_to food_path(@food_conversion.food_id)
  end
end
