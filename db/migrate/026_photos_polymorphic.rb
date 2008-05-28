class PhotosPolymorphic < ActiveRecord::Migration
  def self.up
    add_column :photos, :photographable_id, :integer
    add_column :photos, :photographable_type, :string
    #Photo.find(:all).each do |photo|
    #  photo.photographable_type = "Recipe"
    #  photo.photographable_id = photo.recipe_id
    #  photo.save
    #end
    #remove_column :photos, :recipe_id
    add_column :photos, :favorite, :boolean, :default => false
  end

  def self.down
  end
end
