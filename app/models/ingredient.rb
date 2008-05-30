# == Schema Information
# Schema version: 34
#
# Table name: ingredients
#
#  id                     :integer(11)   not null, primary key
#  recipe_id              :integer(11)   not null
#  food_id                :integer(11)   not null
#  quantity               :decimal(10, 2 default(0.0)
#  units                  :string(11)    default(""), not null
#  created_at             :datetime      
#  updated_at             :datetime      
#  percent_yield          :integer(11)   
#  prep_instructions      :string(255)   
#  position               :integer(11)   
#  conversions_to_display :text          
#

class Ingredient < ActiveRecord::Base
  belongs_to :food
  belongs_to :recipe
  validates_presence_of :food_id, :quantity, :units, :recipe_id, :percent_yield
  
  acts_as_list :scope => :recipe
  
  before_create :assign_position
  after_save :update_recipe_timestamp
  after_destroy :update_recipe_timestamp
  serialize :conversions_to_display
  
  def units_displayable
    if self.units == "tbs"
      "Tbs"
    else
      self.units
    end
  end

  def assign_position
    #self.position = self.recipe.ingredients.last.position + 1
  end
  
  def conversion
    "%01.#{2}f" % (self.to_unit(self.conversions_to_display).scalar) + " " + self.conversions_to_display.to_s unless self.conversions_to_display.nil?
  end

  def to_unit(conversion_unit = nil)
    unit = (self.quantity.to_s + " " + self.units).unit
    if conversion_unit
      if unit.compatible_with?(conversion_unit) 
        unit = unit >> conversion_unit
      else
        found_match = false
        self.food.food_conversions.each do |fconv|
          if conversion_unit.to_unit.compatible_with?(fconv.conversion_units) && unit.compatible_with?(fconv.equivalent_units)
            unit = (((unit >> fconv.equivalent_units).scalar.to_f * fconv.conversion_quantity.to_f / fconv.equivalent_quantity.to_f).to_s + fconv.conversion_units).to_unit(conversion_unit)
            found_match = 1
          elsif conversion_unit.to_unit.compatible_with?(fconv.equivalent_units) && unit.compatible_with?(fconv.conversion_units)
            conv_scalar = (unit >> fconv.conversion_units).scalar
            equiv_scalar = conv_scalar * (fconv.equivalent_quantity.to_f / fconv.conversion_quantity)
            equiv_unit = (equiv_scalar.to_s + fconv.equivalent_units).to_unit
            unit = equiv_unit.to_unit >> conversion_unit
            found_match = 1
          end
        end
        # this happens if the conversion unit isn't compatible and there's no food_conversion
        unit = "0 #{conversion_unit.units} (incompatible_units)" unless found_match
      end 
    end
    return unit
  end
  
  def quantity_to_food_purchase_units
    quantity = 0
    unitized = self.to_unit(self.food.purchase_units)
    quantity = unitized.scalar
    return quantity
  rescue
    # This happens when there's a unit not supported by the ruby-units gem
    return 0
  end
  
  def cost_without_percent_yield
    cost = self.quantity_to_food_purchase_units * self.food.cost_per_unit
  end
  
  def cost
    cost = cost_without_percent_yield
    cost = cost / (self.percent_yield / 100) if self.percent_yield
  end
  
  def compatible_units
    self.food.compatible_units
  end
  
  # If the percent yield is < 100 you'll need to purchase a different amount than the recipe calls for
  def purchase_quantity
    "%01.#{2}f" % (self.quantity / (self.percent_yield / 100) )
  end

  private

  def update_recipe_timestamp
    recipe = self.recipe
    recipe.updated_at = Time.now
    recipe.save
  end
  
#  def validate
#    errors.add("units", "are not compatible with the food's units") unless self.to_unit.compatible_with?(self.food.purchase_units.unit)
#  end
end
