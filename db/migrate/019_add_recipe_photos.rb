class AddRecipePhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :recipe_id, :integer
  end

  def self.down
  end
end
