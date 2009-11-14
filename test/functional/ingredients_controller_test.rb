require File.dirname(__FILE__) + '/../test_helper'
require 'ingredients_controller'

# Re-raise errors caught by the controller.
class IngredientsController; def rescue_action(e) raise e end; end

class IngredientsControllerTest < ActionController::TestCase
  fixtures :ingredients, :recipes

  def setup
    @controller = IngredientsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as(:quentin)
    @recipe = Recipe.find(:first)
  end

  def test_should_get_index
    get :index, :recipe_id => 1
    assert_response :success
    assert assigns(:ingredients)
  end

  def test_should_get_new
    get :new, :recipe_id => @recipe
    assert_response :success
  end

  def test_should_create_ingredient
    old_count = Ingredient.count
    post :create, :recipe_id => @recipe,
                  :food => {:name => "carrots"},
                  :ingredient => {:quantity => 1,
                                  :units => "oz",
                                  :percent_yield => "100",
                                  :position => 1}
    assert_equal old_count+1, Ingredient.count

    assert_redirected_to recipe_path(@recipe)
  end

  def test_should_show_ingredient
    get :show, :recipe_id => @recipe, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    recipe = Recipe.find(1)
    get :edit, :id => recipe.ingredients.first.id, :recipe_id => recipe.id
    assert_response :success
  end

  def test_should_update_ingredient
    put :update, :recipe_id => @recipe, :id => @recipe.ingredients.first, :ingredient => {:percent_yield => 75 }
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  def test_should_destroy_ingredient
    old_count = Ingredient.count
    delete :destroy, :recipe_id => @recipe, :id => @recipe.ingredients.first.id
    assert_equal old_count-1, Ingredient.count

    assert_redirected_to recipe_ingredients_path
  end
end
