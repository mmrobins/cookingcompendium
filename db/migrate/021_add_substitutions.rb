class AddSubstitutions < ActiveRecord::Migration
  def self.up
    create_table :substitutions do |t|
      t.column :food_id, :integer
      t.column :substitution_id, :integer
    end
  end

  def self.down
  end
end
