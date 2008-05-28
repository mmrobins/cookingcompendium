class UsersController < ApplicationController
  layout "cookbook"
  skip_before_filter :login_required, :only => [:new, :create, :activate]
  # render new.rhtml
  def new
  end

  def create
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    redirect_back_or_default(home_path)
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def activate
    self.current_user = User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.activated?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default(home_path)
  end
  
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.find_recent(:all)
    # This returns the 5 top rated recipes
    # includes private recipes if looking at your own recipes
    if logged_in? && @user.id == @current_user.id
      @popular_recipes = @user.recipes.sort_by {|recipe| recipe.rating}.reverse.slice(0,5)
    else
      @popular_recipes = @user.recipes.find_public(:all).sort_by {|recipe| recipe.rating}.reverse.slice(0,5)
    end
  end

end
