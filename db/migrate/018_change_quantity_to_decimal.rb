class ChangeQuantityToDecimal < ActiveRecord::Migration
  def self.up
    change_column :ingredients, :quantity, :decimal, :precision => 10, :scale => 2, :default => 0.0
    remove_column :recipes, :deleted_at
  end

  def self.down
  end
end
