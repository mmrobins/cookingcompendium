# == Schema Information
# Schema version: 30
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

class Dish < ActiveRecord::Base
  belongs_to :menu
  belongs_to :recipe
  validates_presence_of :menu_id, :recipe_id, :servings
  
  def serving_ratio
    self.servings / self.recipe.servings
  end
  
  def cost
    cost = self.recipe.cost * self.serving_ratio
  end
  
  def ingredients
    self.recipe.with_servings(self.servings).ingredients
  end
    
    
end
