class DeleteUnwantedColumnsAndAddIndexes < ActiveRecord::Migration
  def self.up
    remove_column :recipes, :public
    remove_column :users, :deleted_at
    remove_column :foods, :deleted_at
    add_index :foods, :name
    add_index :recipes, :user_id
    add_index :ingredients, :recipe_id
    add_index :ingredients, :food_id
    add_index :food_conversions, :food_id
    add_index :dishes, :recipe_id
    add_index :dishes, :meal_id
  end

  def self.down
  end
end
