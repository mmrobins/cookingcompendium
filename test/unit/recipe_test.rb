require File.dirname(__FILE__) + '/../test_helper'

class RecipeTest < Test::Unit::TestCase
  fixtures :recipes

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_cost
    recipe = Recipe.find(1)
    cost = 0
    recipe.ingredients.each do |ing|
      cost += ing.cost
    end
    assert_equal cost, recipe.cost
  end
end
