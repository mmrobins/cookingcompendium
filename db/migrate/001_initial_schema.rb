class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table "foods", :force => true do |t|
      t.column "name",              :string,  :limit => 30,                                :default => "", :null => false
      t.column "food_type",         :string,  :limit => 20,                                :default => "", :null => false
      t.column "purchase_units",    :string,  :limit => 10,                                :default => "", :null => false
      t.column "purchase_quantity", :decimal,               :precision => 10, :scale => 2,                 :null => false
      t.column "purchase_price",    :decimal,               :precision => 10, :scale => 2,                 :null => false
    end
  
    create_table "ingredients", :force => true do |t|
      t.column "recipe_id", :integer,                               :null => false
      t.column "food_id",   :integer,                               :null => false
      t.column "quantity",  :integer,                               :null => false
      t.column "units",     :string,  :limit => 11, :default => "", :null => false
    end
  
    create_table "recipes", :force => true do |t|
      t.column "title",        :string,  :default => "", :null => false
      t.column "recipe_type",  :string
      t.column "prep_time",    :integer
      t.column "instructions", :text
    end
  end
end
