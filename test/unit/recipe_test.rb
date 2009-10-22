require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def test_cost
    recipe = Recipe.find(1)
    cost = 0
    recipe.ingredients.each do |ing|
      cost += ing.cost
    end
    assert_equal cost, recipe.cost
  end
end
