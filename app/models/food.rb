# == Schema Information
# Schema version: 30
#
# Table name: foods
#
#  id                :integer(11)   not null, primary key
#  name              :string(30)    default(""), not null
#  food_type         :string(20)    default(""), not null
#  purchase_units    :string(10)    default(""), not null
#  purchase_quantity :decimal(10, 2 not null
#  purchase_price    :decimal(10, 2 not null
#  created_at        :datetime      
#  updated_at        :datetime      
#  deleted_at        :datetime      
#

class Food < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, :through => :ingredients
  has_many :substitutions
  has_many :substitutes, :through => :substitutions
  has_many :food_conversions
  validates_presence_of :name, :food_type, :purchase_units, :purchase_price, :purchase_quantity
  
  require 'csv'
  UNITLESS = %w(bu each doz).sort
  WEIGHTS = %w(lbs oz g kg mg).sort
  VOLUMES = %w(floz tbs tsp pt qt gal l ml cu qt gal).sort
  UNITFULL = (WEIGHTS + VOLUMES).sort
  UNITS = (UNITLESS + UNITFULL).sort
  FOOD_TYPES = %w(meat poultry pork seafood grocery dry spice dairy produce bread alcohol stock).sort
  
  def cost_per_unit
    self.purchase_price / self.purchase_quantity
  end
  
  def to_unit
    (self.purchase_quantity.to_s + " " + self.purchase_units).unit
  end
  
  def compatible_units
    # Even unitless units are compatible with themselves
    comp_units = [self.purchase_units]
    
    Food::UNITS.each do |unit|
      comp_units << unit if self.compatible_with? unit
    end
    return comp_units.uniq.sort
  end
  
  def compatible_with?(unit)
    food_units = self.to_unit
    unit = unit.to_unit
    compatible = false
    # if both are volumes or both are mass return true
    if food_units.compatible_with? unit
      compatible = true
    end
    # we're going to check the food conversions
    self.food_conversions.each do |conv|
      if food_units.compatible_with?(conv.conversion_units.to_unit) && conv.equivalent_units.to_unit.compatible_with?(unit)
        compatible = true
      elsif food_units.compatible_with?(conv.equivalent_units.to_unit) && conv.conversion_units.to_unit.compatible_with?(unit)
        compatible = true
      end
    end
    return compatible
  # If a bad unit type is passed the to_unit will raise an exception
  rescue
    return false
  end
  
  def self.import
    test = []
    CSV::Reader.parse(File.open('food.csv')) do |row|
      # The first non blank row has the job number and date
      # if !row[0].nil? && !row[1].nil? && !row[2].nil? && row[3].nil?
      unless row[0].nil? || row[0].empty?
      f = Food.new(:name => row[0], 
               :purchase_quantity => 1, 
               :purchase_units => row[3], 
               :purchase_price => row[4],
               :food_type => row[5])
      f.save
      end
    end
    return test.to_sentence
  end
end
