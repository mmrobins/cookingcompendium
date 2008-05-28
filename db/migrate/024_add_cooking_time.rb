class AddCookingTime < ActiveRecord::Migration
  def self.up
    add_column :recipes, :cooking_time, :integer, :limit => 6
  end

  def self.down
  end
end
