class AddConversionColumnToIngredient < ActiveRecord::Migration
  def self.up
    # Basically I want a way to display conversion units on the recipe
    # I need to make sure in the model that only units that
    # have a food_conversion available are available
    add_column :ingredients, :conversions_to_display, :text
  end

  def self.down
  end
end
