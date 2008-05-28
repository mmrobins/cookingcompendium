class AddTimeStampColumns < ActiveRecord::Migration
  def self.up
    add_column :recipes, :created_at, :datetime
    add_column :recipes, :updated_at, :datetime
    add_column :foods, :created_at, :datetime
    add_column :foods, :updated_at, :datetime
    add_column :ingredients, :created_at, :datetime
    add_column :ingredients, :updated_at, :datetime
  end

  def self.down
  end
end
