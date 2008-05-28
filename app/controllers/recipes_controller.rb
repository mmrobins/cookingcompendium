class RecipesController < ApplicationController
  layout 'cookbook', :except => [:printable]
  auto_complete_for :food, :name
  skip_before_filter :login_required, :only => [:index, :show, :printable ]
  after_filter :add_recent_recipe_to_history, :only => [:show, :edit]
  before_filter :authorized_to_edit?, :only => [:edit, :edit_basics]
  before_filter :authorized_to_show?, :only => [:show, :printable]

  def add_recent_recipe_to_history
    session[:recent_recipes] = Array.new unless session[:recent_recipes]
    session[:recent_recipes] << (@recipe) unless session[:recent_recipes].include? @recipe
  end
   
  def authorized_to_edit?
    @recipe = Recipe.find(params[:id])
    unless @recipe.user_id == @current_user.id
      flash[:notice] = "You're not authorized to edit that recipe"
      redirect_to recipes_path
    end
  end

  def authorized_to_show?
    @recipe = Recipe.find(params[:id])
    if @recipe.private && !logged_in?
      flash[:notice] = "Please login to view that recipe"
      access_denied 
    elsif @recipe.private && (@current_user.id != @recipe.user_id)
      flash[:notice] = "You're not authorized to view that recipe"
      redirect_to recipes_path
    end
  end

  # GET /recipes
  # GET /recipes.xml
  def index
    add_to_sortable_columns("search", :model => Recipe)
    if params[:user_id] && logged_in? && @current_user.id.to_i == params[:user_id].to_i
      @user = User.find(params[:user_id])
      @recipes = @user.recipes.paginate(:all,
                   :order => sortable_order('search', Recipe, 'title'),
                   :page => params[:page])
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @recipes = @user.recipes.paginate_public(:all,
                   :order => sortable_order('search', Recipe, 'title'),
                   :page => params[:page])
    else
      @recipes = Recipe.paginate(:all,
                   :conditions => ["NOT private OR user_id = ?", @current_user.id],
                   :order => sortable_order('search', Recipe, 'id'),
                   :page => params[:page])
    end
    # So that after adding a food we can come back to this
    store_location

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @recipes.to_xml }
    end
  end

  def print_all
    if logged_in?
      @recipes = @current_user.recipes
    else
      redirect_to recipes_path
    end
  end

  def printable
    if params[:servings]
      @recipe = @recipe.with_servings(params[:servings])
    end
    render :action => "recipes/printable", :layout => "printable"
  end

  # GET /recipes/1
  # GET /recipes/1.xml
  def show
    if params[:servings]
      @recipe = @recipe.with_servings(params[:servings])
    end

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @recipe.to_xml }
    end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # This allows editing the instructions and ingredients
  def edit
    respond_to do |format|
      format.html # show.rhtml
      format.js
      format.xml  { render :xml => @recipe.to_xml }
    end
  end
  
  # This allows editing the title, servings and other basic details
  def edit_basics
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = Recipe.new(params[:recipe])

    respond_to do |format|
      if @current_user.recipes << @recipe
        flash[:notice] = 'Recipe was successfully created.'
        format.html { redirect_to edit_recipe_url(@recipe) }
        format.xml  { head :created, :location => recipe_url(@recipe) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors.to_xml }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.xml
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        flash[:notice] = 'Recipe was successfully updated.'
        format.html { redirect_to edit_recipe_url(@recipe) }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit_basics" }
        format.js
        format.xml  { render :xml => @recipe.errors.to_xml }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.xml  { head :ok }
    end
  end
end
