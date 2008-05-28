class CreateDishesTableWithIndex < ActiveRecord::Migration
  def self.up
    drop_table "dishes"
    create_table "dishes", :force => true do |t|
      t.column :recipe_id, :integer, :null => false
      t.column :meal_id, :integer, :null => false
      t.column :servings, :decimal, :precision => 6, :scale => 2
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
  end
end
