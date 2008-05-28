class RenameMealsToMenus < ActiveRecord::Migration
  def self.up
    rename_table :meals, :menus
    rename_column :dishes, :meal_id, :menu_id
    add_column :menus, :user_id, :integer 
  end

  def self.down
  end
end
