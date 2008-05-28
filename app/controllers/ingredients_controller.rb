class IngredientsController < ApplicationController
  before_filter :find_recipe
  
  def add_new_conversion_to_display
    @ingredient = Ingredient.find(params[:id])
    @ingredient.conversions_to_display = params[:new_unit]
    @ingredient.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def order
  
  end
  
  def move
    if %w[move_lower move_higher move_to_top move_to_bottom].include?(params[:move_method])
      @recipe.ingredients.find(params[:id]).send(params[:move_method])
    end
    redirect_to recipe_path(@recipe)
  end
  
  # GET /ingredients
  # GET /ingredients.xml
  def index
    @ingredients = Ingredient.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @ingredients.to_xml }
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.xml
  def show
    @ingredient = Ingredient.find(params[:id])
    @alternate_ingredient = @ingredient.to_unit(@ingredient.conversions_to_display) unless @ingredient.conversions_to_display.nil?
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @ingredient.to_xml }
    end
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1;edit
  def edit
    @ingredient = Ingredient.find(params[:id])
    @food = @ingredient.food
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /ingredients
  # POST /ingredients.xml
  def create
    @ingredient = Ingredient.new(params[:ingredient])
    @food = Food.find_by_name(params[:food][:name])
    @ingredient.food_id = @food.id if @food
    respond_to do |format|
      if @recipe.ingredients << @ingredient
        flash[:notice] = 'Ingredient was successfully added.'
        format.html { redirect_to recipe_url(@recipe) }
        format.js
        format.xml  { head :created, :location => ingredient_url(@ingredient) }
      else
        format.html { render :action => "new" }
        format.js
        format.xml  { render :xml => @ingredient.errors.to_xml }
      end
    end
  end

  # PUT /ingredients/1
  # PUT /ingredients/1.xml
  def update
    @ingredient = Ingredient.find(params[:id])

    respond_to do |format|
      if @ingredient.update_attributes(params[:ingredient])
        flash[:notice] = 'Ingredient was successfully updated.'
        format.html { redirect_to recipe_url(@recipe) }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js
        format.xml  { render :xml => @ingredient.errors.to_xml }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.xml
  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to ingredients_url }
      format.js
      format.xml  { head :ok }
    end
  end
end
