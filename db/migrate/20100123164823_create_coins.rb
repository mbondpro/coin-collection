class CreateCoins < ActiveRecord::Migration
  def self.up
    create_table :coins do |t|
      t.references :category, :null => :false
      t.references :user
      t.string :name, :null => :false
      t.string :mint
      t.integer :year, :null => :false
      t.string :feature
      t.integer :mintage, :limit => 8
      t.text :history

      t.timestamps
    end
  end

  def self.down
    drop_table :coins
  end
end
