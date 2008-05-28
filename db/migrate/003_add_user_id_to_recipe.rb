class AddUserIdToRecipe < ActiveRecord::Migration
  def self.up
    add_column :recipes, :user_id, :integer, :limit => 10, :null => false
    add_column :recipes, :public, :boolean    
  end

  def self.down
  end
end
