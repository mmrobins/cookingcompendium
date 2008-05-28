class AddDescriptions < ActiveRecord::Migration
  def self.up
    add_column :recipes, :description, :text
    add_column :meals, :description, :text
  end

  def self.down
  end
end
