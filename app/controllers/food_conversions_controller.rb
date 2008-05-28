class FoodConversionsController < ApplicationController
  before_filter :find_food
  layout 'cookbook'

  # GET /food_conversions/new
  def new
    @food_conversion = FoodConversion.new(params[:food_conversion])

  end

  # POST /food_conversions
  # POST /food_conversions.xml
  def create
    @food_conversion = FoodConversion.new(params[:food_conversion])

    respond_to do |format|
      if @food.food_conversions << @food_conversion
        flash[:notice] = 'FoodConversion was successfully created.'
        format.html { redirect_back_or_default food_url(@food) }
        format.xml  { head :created, :location => food_conversion_url(@food_conversion) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @food_conversion.errors.to_xml }
      end
    end
  end

  # DELETE /food_conversions/1
  # DELETE /food_conversions/1.xml
  def destroy
    @food_conversion = FoodConversion.find(params[:id])
    @food_conversion.destroy

    respond_to do |format|
      format.html { redirect_to food_url(@food) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_food
    @food = Food.find(params[:food_id])
  end
end
