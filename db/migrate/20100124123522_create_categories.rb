class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :parent_id
      t.references :user
      t.string :name, :null => :false
      t.string :years
      t.boolean :official, :null => :false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
