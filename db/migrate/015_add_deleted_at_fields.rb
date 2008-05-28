class AddDeletedAtFields < ActiveRecord::Migration
  def self.up
    add_column :foods, :deleted_at, :datetime
    add_column :recipes, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
  end

  def self.down
  end
end
