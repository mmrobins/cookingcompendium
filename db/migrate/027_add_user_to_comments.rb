class AddUserToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_id, :integer
  end

  def self.down
  end
end
