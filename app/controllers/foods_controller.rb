class FoodsController < ApplicationController
  before_filter :find_food, :only => [:show, :edit, :update, :destroy]
  layout 'cookbook'

  def finder
    @food = Food.find_by_name(params[:food][:name]) || params[:food][:name]
    if @food.class == Food
      @ingredient = Ingredient.new
    else
      @foods = Food.find(:all,
                 :conditions => [ "LOWER(name) LIKE ?", '%' + @food.downcase + '%' ], 
                 :order => "name ASC",
                 :limit => 10) 
    end
    @recipe = Recipe.find(params[:recipe_id])
    # render :text => @food.to_yaml
  end
  
  # GET /foods
  # GET /foods.xml
  def index
    @foods = Food.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @foods.to_xml }
    end
  end

  # GET /foods/1
  # GET /foods/1.xml
  def show
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @food.to_xml }
    end
  end

  # GET /foods/new
  def new
    @recipe = Recipe.find(params[:recipe_id]) if params[:recipe_id]
    @ingredient = Ingredient.new if params[:recipe_id]
    @food = Food.new(params[:food])
  end

  # GET /foods/1;edit
  def edit
  end

  # POST /foods
  # POST /foods.xml
  def create
    @food = Food.new(params[:food])
    respond_to do |format|
      if @food.save
        if params[:recipe_id]
          @recipe = Recipe.find(params[:recipe_id])
          ingredient = Ingredient.new(params[:ingredient])
          ingredient.food_id = @food.id
          @recipe.ingredients << ingredient
        end
        flash[:notice] = 'Food was successfully created.'
        format.html do 
          if params[:recipe_id]
            redirect_to recipe_url(@recipe)
          else
            redirect_to food_url(@food)
          end
        end
        format.xml  { head :created, :location => food_url(@food) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @food.errors.to_xml }
      end
    end
  end

  # PUT /foods/1
  # PUT /foods/1.xml
  def update
    respond_to do |format|
      if @food.update_attributes(params[:food])
        flash[:notice] = 'Food was successfully updated.'
        format.html { redirect_to food_url(@food) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @food.errors.to_xml }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.xml
  def destroy
    @food.destroy

    respond_to do |format|
      format.html { redirect_to food_url(@food) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_food
    @food = Food.find(params[:id])
  end
end
