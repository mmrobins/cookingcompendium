# == Schema Information
# Schema version: 30
#
# Table name: substitutions
#
#  id              :integer(11)   not null, primary key
#  food_id         :integer(11)   
#  substitution_id :integer(11)   
#

class Substitution < ActiveRecord::Base
  belongs_to :food
  belongs_to :substitute, :class_name => "Food", :foreign_key => "substitution_id"
end
