# == Schema Information
# Schema version: 30
#
# Table name: comments
#
#  id               :integer(11)   not null, primary key
#  comment          :string(255)   
#  commentable_id   :integer(11)   
#  commentable_type :string(255)   
#  created_at       :datetime      
#  updated_at       :datetime      
#  user_id          :integer(11)   
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  validates_presence_of :comment, :commentable_id, :commentable_type, :user_id
end
