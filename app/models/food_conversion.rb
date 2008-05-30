# == Schema Information
# Schema version: 34
#
# Table name: food_conversions
#
#  id                  :integer(11)   not null, primary key
#  food_id             :integer(7)    
#  conversion_quantity :decimal(10, 2 
#  conversion_units    :string(10)    
#  equivalent_quantity :decimal(10, 2 
#  equivalent_units    :string(10)    
#  created_at          :datetime      
#  updated_at          :datetime      
#

class FoodConversion < ActiveRecord::Base
  belongs_to :food
  validates_presence_of :conversion_quantity, :conversion_units, :equivalent_quantity, :equivalent_units, :food_id
  validates_numericality_of :conversion_quantity, :equivalent_quantity
  # Make sure the user doesn't try to define a conversion between two units of the same type since these are already defined
  # For example we dont want the user to try to say 2l = 10gal or something ridiculous
  validates_each :conversion_units do |record, attr, value|
    record.errors.add attr, 'No need to define a conversion between two ' + value.to_unit.kind.to_s.pluralize if value.to_unit.kind == record.equivalent_units.to_unit.kind
  end
end
