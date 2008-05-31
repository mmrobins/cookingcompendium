class DishesController < ApplicationController
  layout 'cookbook'
  before_filter :find_menu

  # GET /dishes/new
  def new
    @dish = Dish.new
  end

  # GET /dishes/1;edit
  def edit
    @dish = Dish.find(params[:id])
  end

  # POST /dishes
  # POST /dishes.xml
  def create
    @dish = Dish.new(params[:dish])
    @recipe = Recipe.find(params[:recipe_id])
    @dish.recipe_id = @recipe.id
    @dish.servings = @recipe.servings

    respond_to do |format|
      if @menu.dishes << @dish
        flash[:notice] = 'Dish was successfully created.'
        format.html { redirect_to menu_url(@menu) }
        format.xml  { head :created, :location => menu_url(@menu) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dish.errors.to_xml }
      end
    end
  end

  # PUT /dishes/1
  # PUT /dishes/1.xml
  def update
    @dish = Dish.find(params[:id])

    respond_to do |format|
      if @dish.update_attributes(params[:dish])
        flash[:notice] = 'Dish was successfully updated.'
        format.html { redirect_to menu_url(@menu) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dish.errors.to_xml }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.xml
  def destroy
    @dish = Dish.find(params[:id])
    @dish.destroy

    respond_to do |format|
      format.html { redirect_to dishes_url }
      format.js
      format.xml  { head :ok }
    end
  end
  
  def find_menu
    @menu = Menu.find(params[:menu_id])
  end
end
