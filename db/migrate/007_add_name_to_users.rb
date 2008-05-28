class AddNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string, :length => 40
  end

  def self.down
  end
end
