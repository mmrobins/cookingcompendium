require 'test_helper'

class MenuTest < ActiveSupport::TestCase

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_cost_should_be_sum_of_dish_costs
    menu = Menu.find(1)
    cost = 0
    menu.dishes.each do |dish|
      cost += dish.cost
    end
    assert_equal cost, menu.cost
  end
end
