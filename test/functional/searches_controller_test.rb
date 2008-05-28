require File.dirname(__FILE__) + '/../test_helper'
require 'searches_controller'

# Re-raise errors caught by the controller.
class SearchesController; def rescue_action(e) raise e end; end

class SearchesControllerTest < Test::Unit::TestCase
  def setup
    @controller = SearchesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
