class Conversions < ActiveRecord::Migration
  def self.up
    create_table :food_conversions, :force => true do |t|
      t.column :food_id, :integer, :limit => 7
      t.column :conversion_quantity, :decimal, :precision => 10, :scale => 2
      t.column :conversion_units,    :string,  :limit => 10
      t.column :equivalent_quantity, :decimal, :precision => 10, :scale => 2
      t.column :equivalent_units,    :string,  :limit => 10
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
  end
end
