# == Schema Information
# Schema version: 30
#
# Table name: menus
#
#  id          :integer(11)   not null, primary key
#  name        :string(30)    default(""), not null
#  created_at  :datetime      
#  updated_at  :datetime      
#  description :text          
#

class Menu < ActiveRecord::Base
  has_many :dishes, :dependent => :destroy
  validates_presence_of :name
  
  def cost
    cost = 0
    self.dishes.each do |dish|
      cost += dish.cost
    end
    return cost
  end
  
  def ingredients
    ings = Array.new
    self.dishes.each do |dish|
      ings += dish.ingredients
    end
    return ings
  end
end
