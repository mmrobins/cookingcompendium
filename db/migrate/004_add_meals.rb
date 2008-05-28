class AddMeals < ActiveRecord::Migration
  def self.up
    create_table "meals", :force => true do |t|
      t.column :name,       :string,  :limit => 30, :default => "", :null => false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
    
    create_table "meals_recipes", :id => false, :force => true do |t|
      t.column "recipe_id", :integer
      t.column "meal_id",  :integer
    end
  end

  def self.down
  end
end
