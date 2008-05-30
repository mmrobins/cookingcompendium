# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  #include ExceptionNotifiable
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_cookbook_session_id'
  include AuthenticatedSystem
  before_filter :login_from_cookie
  before_filter :login_required
  before_filter :current_user
  
  private
  
  def find_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
