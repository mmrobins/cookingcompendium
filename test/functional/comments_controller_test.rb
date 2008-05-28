require File.dirname(__FILE__) + '/../test_helper'
require 'comments_controller'

# Re-raise errors caught by the controller.
class CommentsController; def rescue_action(e) raise e end; end

class CommentsControllerTest < Test::Unit::TestCase
  fixtures :comments, :recipes, :users

  def setup
    @controller = CommentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @new_comment = {:comment => "test comment"}
    @comment = Comment.find 1
    @recipe = Recipe.find 1
    login_as(:quentin)
  end
  
  def test_should_create_comment
    old_count = Comment.count
    @current_user = User.find 1
    post :create, :comment => {:comment => "cow"}, :recipe_id => @recipe.id
    assert_equal old_count+1, Comment.count
    
    assert_redirected_to recipe_path(@recipe)
  end

#  def test_should_get_edit
#    get :edit, :id => 1
#    assert_response :success
#  end
#  
#  def test_should_update_comment
#    put :update, :id => 1, :comment => { }
#    assert_redirected_to comment_path(assigns(:comment))
#  end
end
