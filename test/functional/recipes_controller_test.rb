require File.dirname(__FILE__) + '/../test_helper'
require 'recipes_controller'

# Re-raise errors caught by the controller.
class RecipesController; def rescue_action(e) raise e end; end

class RecipesControllerTest < Test::Unit::TestCase
  fixtures :recipes

  def setup
    @controller = RecipesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as(:quentin)
    @recipe = recipes(:quentins_private_recipe)
  end

  def test_show_printable
    get :printable, :id => @recipe
    assert_response :success
    assert_template "printable"
  end

  def test_should_redirect_to_index_if_not_authorized_to_edit
    # logged in as quentin we should get redirected if we try
    # to edit matt's private recipes
    get :edit, :id => recipes(:matts_private_recipe) 
    assert_redirected_to recipes_path
  end

  def test_should_redirect_to_index_if_not_authorized_to_show
    # logged in as quentin we should get redirected if we try
    # to view matt's private recipes
    get :show, :id => recipes(:matts_private_recipe)
    assert_redirected_to recipes_path
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:recipes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_recipe
    old_count = Recipe.count
    post :create, :recipe => { :title => "Oatmeal", 
                               :recipe_type => "side",
                               :prep_time => 10,
                               :user_id => 1,
                               :servings => 2.5,
                               :serving_quantity => 1,
                               :serving_units => "cu",
                               :private => true }
    assert_equal old_count+1, Recipe.count
    
    # We should immediately start editing the recipe since
    # this phase of creation hasn't allowed us to add ingredients yet
    assert_redirected_to edit_recipe_path(assigns(:recipe))
  end

  def test_should_show_recipe
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_recipe
    put :update, :id => 1, :recipe => {:prep_time => 15 }
    assert_redirected_to edit_recipe_path(assigns(:recipe))
  end
  
  def test_should_destroy_recipe
    old_count = Recipe.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Recipe.count
    
    assert_redirected_to recipes_path
  end
end
