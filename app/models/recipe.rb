# == Schema Information
# Schema version: 30
#
# Table name: recipes
#
#  id               :integer(11)   not null, primary key
#  title            :string(255)   default(""), not null
#  recipe_type      :string(255)
#  prep_time        :integer(11)
#  instructions     :text
#  user_id          :integer(10)   not null
#  public           :boolean(1)
#  created_at       :datetime
#  updated_at       :datetime
#  servings         :decimal(6, 2)
#  serving_quantity :decimal(6, 2)
#  serving_units    :string(255)
#  description      :text
#  cooking_time     :integer(6)
#  private          :boolean(1)
#

class Recipe < ActiveRecord::Base
  has_many :photos, :as => :photographable
  has_many :ingredients, :order => "position", :dependent => :delete_all
  belongs_to :user
  has_many :dishes
  has_many :menus, :through => :dishes
  has_many :comments, :as => :commentable
  validates_presence_of :title, :recipe_type, :user_id
  # If the user enters servings they'd better enter what the serving size is
  validates_presence_of :serving_quantity, :if => Proc.new { |recipe| !recipe.servings.nil? }, :message => "can't be blank if you specify servings.  A number of servings without a serving size is meaningless"
  validates_presence_of :serving_units, :if => Proc.new { |recipe| !recipe.serving_quantity.nil? }, :message => "can't be blank if you specify a serving size quantity."
  validates_inclusion_of :private, :in => [true, false]
  validates_numericality_of :prep_time, :cooking_time, :only_integer => true, :allow_nil => true
  validates_numericality_of :servings, :serving_quantity, :allow_nil => true
  acts_as_rateable
  #acts_as_ferret({:fields => [:title, :description, :instructions, :ingredients_with_spaces]})

  RECIPE_TYPES = ["entree", "side", "soup", "salad", "bread", "dessert"]

  cattr_reader :per_page
  @@per_page = 10

  named_scope :public, :conditions => ["NOT private"]
  named_scope :private, :conditions => ["private"]
  named_scope :recent, :conditions => ["updated_at"], :order => ["updated_at DESC"], :limit => 10

  def ingredients_with_spaces
    self.ingredients_in_array.join(" ")
  end

  def ingredients_in_array
    self.ingredients.collect {|i| i.food.name}
  end

  def cost
    cost = 0
    self.ingredients.each do |ingredient|
      cost += ingredient.cost
    end
    return cost
  end

  def cost_per_serving
    serving_cost = (self.cost.to_f / self.servings if self.servings.to_f)
  end

  def favorite_photo
    self.photos.find(:first, :conditions => ["favorite"]) || self.photos.first
  end

  # this works as long as you don't try to work the the original recipe
  # immediately afterwords because it's ingredients get all messed calling this
  # haven't figured out how to have a duplicate recipe with duplicate ingredients
  # since you need to save the recipe to have different ingredients linked to it
  def with_servings(new_serving_size)
    recipe_with_x_servings = self.dup
    serving_ratio = new_serving_size.to_f / self.servings
    recipe_with_x_servings.servings = new_serving_size
    ings = Array.new
    recipe_with_x_servings.ingredients.each do |ingredient|
      ing_new = ingredient.dup
      ing_new.quantity = ingredient.quantity * serving_ratio
      ings << ingredient
    end
    recipe_with_x_servings.ingredients = ings
    return recipe_with_x_servings
  end
end
