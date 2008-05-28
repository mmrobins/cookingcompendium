class SearchesController < ApplicationController
  layout 'cookbook'
  skip_before_filter :login_required
  
  def index
    search_query = params[:query].split(" ").collect{|term| "*" + term + "*"}.join(" OR ")
    #@recipes = Recipe.find_public(:all, :conditions => ["title LIKE (?)", search_query])
    @recipes = Recipe.find_by_contents(search_query, {}, :conditions => "NOT private")
    if logged_in?
      @recipes = @recipes + Recipe.find_by_contents(search_query, {}, :conditions => ["private AND user_id = ?", @current_user.id])
    end
    #@menus = Menu.find_by_contents search_query
    #@foods = Food.find_by_contents search_query
  end
end
