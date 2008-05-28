class Comments < ActiveRecord::Migration
  def self.up
    drop_table :comments
    create_table :comments do |t|
      t.column :comment, :string
      t.column :addressable_id, :integer
      t.column :addressable_type, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
  end
end
