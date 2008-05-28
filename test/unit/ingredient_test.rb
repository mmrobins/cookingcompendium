require File.dirname(__FILE__) + '/../test_helper'

class IngredientTest < Test::Unit::TestCase
  fixtures :ingredients
  
  @@ingredient_default_values = {
    :recipe_id => 1,
    :food_id => 1,
    :quantity => 2.5,
    :units => "lbs",
    :percent_yield => 100,
    :prep_instructions => "chop finely",
    :position => "1"
  }
  
  def test_creating_ingredient_should_change_recipe_updated_at
    recipe = Recipe.find 1
    original = recipe.updated_at
    ingredient = create 
    after_create = recipe.reload.updated_at
    assert original < after_create
  end

  def test_update_ingredient_should_change_recipe_updated_at
    recipe = Recipe.find 1
    original = recipe.updated_at
    ingredient = recipe.ingredients.first
    ingredient.save
    after_update = recipe.reload.updated_at
    assert original < after_update
  end

  def test_delete_ingredient_should_change_recipe_updated_at
    recipe = Recipe.find 1
    original = recipe.updated_at
    ingredient = recipe.ingredients.first
    ingredient.destroy
    after_update = recipe.reload.updated_at
    assert original < after_update
  end

  def test_to_unit
    ingredient = create
    assert_equal ingredient.to_unit.units, ingredient.units
  end
  
  def test_quantity_to_food_purchase_units
    ingredient = create(:units => "g")
    assert_not_equal ingredient.units, ingredient.food.purchase_units
    assert_equal ingredient.quantity_to_food_purchase_units, (ingredient.to_unit >> ingredient.food.purchase_units).scalar
  end
  
  def test_cost
    ingredient = Ingredient.find(1)
    assert_equal ingredient.cost, ingredient.quantity_to_food_purchase_units * ingredient.food.cost_per_unit
  end
  
  def test_should_be_compitable_with_the_same_units_as_food
    ingredient = create
    assert_equal ingredient.compatible_units, ingredient.food.compatible_units
  end
  
  private
  
  def create(options = {})
    Ingredient.create(@@ingredient_default_values.merge(options))
  end
end
