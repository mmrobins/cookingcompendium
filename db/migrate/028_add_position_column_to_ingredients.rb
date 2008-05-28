class AddPositionColumnToIngredients < ActiveRecord::Migration
  def self.up
    add_column :ingredients, :position, :integer
    Recipe.find(:all).each do |recipe|
      i = 1
      recipe.ingredients.each do |ingredient|
        ingredient.position = i
        ingredient.save
        i += 1
      end
    end
  end

  def self.down
  end
end
