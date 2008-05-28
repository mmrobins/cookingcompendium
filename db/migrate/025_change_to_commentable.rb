class ChangeToCommentable < ActiveRecord::Migration
  def self.up
    rename_column :comments, :addressable_id, :commentable_id
    rename_column :comments, :addressable_type, :commentable_type
  end

  def self.down
  end
end
