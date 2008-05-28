class ServingSizeInfo < ActiveRecord::Migration
  def self.up
    add_column :recipes, :servings, :decimal, :precision => 6, :scale => 2
    add_column :recipes, :serving_quantity, :decimal, :precision => 6, :scale => 2
    add_column :recipes, :serving_units, :string
    rename_table :meals_recipes, :dishes
    add_column :dishes, :servings, :decimal, :precision => 6, :scale => 2
  end

  def self.down
  end
end
