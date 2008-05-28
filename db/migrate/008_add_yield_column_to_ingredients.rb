class AddYieldColumnToIngredients < ActiveRecord::Migration
  def self.up
    add_column :ingredients, :percent_yield, :integer, :length => 3
    add_column :ingredients, :prep_instructions, :string
  end

  def self.down
  end
end
