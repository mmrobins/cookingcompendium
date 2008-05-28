# == Schema Information
# Schema version: 30
#
# Table name: photos
#
#  id                  :integer(11)   not null, primary key
#  parent_id           :integer(11)   
#  content_type        :string(255)   
#  filename            :string(255)   
#  thumbnail           :string(255)   
#  size                :integer(11)   
#  width               :integer(11)   
#  height              :integer(11)   
#  created_at          :datetime      
#  updated_at          :datetime      
#  recipe_id           :integer(11)   
#  photographable_id   :integer(11)   
#  photographable_type :string(255)   
#  favorite            :boolean(1)    
#

class Photo < ActiveRecord::Base
  belongs_to :photographable, :polymorphic => true
  has_attachment :content_type => :image, 
                 :storage => :file_system,
                 :processor => "Rmagick",
                 :max_size => 5.megabytes,
                 :thumbnails => { :thumb => '100x100>' }

  validates_as_attachment 
end
