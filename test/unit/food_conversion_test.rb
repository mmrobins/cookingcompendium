require 'test_helper'

class FoodConversionTest < ActiveSupport::TestCase
  @@food_conversion_default_values = {
    :food_id => 1,
    :conversion_quantity => 1,
    :conversion_units => "lbs",
    :equivalent_quantity => 8,
    :equivalent_units => "cups"
  }

  # Ex can't create a conversion that says 1 lb = 2 lb or 1lb = 1 g
  def test_conversion_types_should_be_different
    food_conversion = create
    assert food_conversion.valid?, "The conversion was invalid:\n #{food_conversion.to_yaml}"
    food_conversion.conversion_units = food_conversion.equivalent_units
    assert !food_conversion.valid?, "Conversion should have been invalid"
    assert_not_nil food_conversion.errors.on(:conversion_units), "conversion_units should have had an error"
  end

  private

  def create(options = {})
    FoodConversion.create(@@food_conversion_default_values.merge(options))
  end
end
