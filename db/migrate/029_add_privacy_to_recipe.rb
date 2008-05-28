class AddPrivacyToRecipe < ActiveRecord::Migration
  def self.up
    add_column :recipes, :private, :boolean 
  end

  def self.down
  end
end
