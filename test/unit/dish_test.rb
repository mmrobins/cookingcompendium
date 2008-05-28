require File.dirname(__FILE__) + '/../test_helper'

class DishTest < Test::Unit::TestCase
  fixtures :dishes, :menus, :recipes
  
#
# Table name: dishes
#
#  id         :integer(11)   not null, primary key
#  recipe_id  :integer(11)   not null
#  menu_id    :integer(11)   not null
#  servings   :decimal(6, 2) 
#  created_at :datetime      
#  updated_at :datetime      
#

  @@dish_default_values = {
    :recipe_id => 1,
    :menu_id => 1,
    :servings => 2.5,
  }
  
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def cost_should_be_proportional_to_recipe_cost_by_serving
    dish = create
    serving_ratio = dish.servings / dish.recipe.servings
    assert_equal dish.cost, dish.recipe.cost * serving_ratio
  end
  
  private
  
  def create(options = {})
    Dish.create(@@dish_default_values.merge(options))
  end
end
