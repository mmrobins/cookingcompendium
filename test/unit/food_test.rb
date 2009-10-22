require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  def test_cost_per_unit
    food = Food.find(1)
    assert_equal food.cost_per_unit, (food.purchase_price / food.purchase_quantity)
  end

  def test_to_unit
    food = Food.find(1)
    assert_equal food.to_unit, (food.purchase_quantity.to_s + " " + food.purchase_units).unit
  end

  def compatible_units
    food = Food.find(1)
    assert_equal food.compatible_units, Food::UNITS.select { |u| food.to_unit.compatible_with?(u) }
  end
end
