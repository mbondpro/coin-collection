class AddHistoryToCategory < ActiveRecord::Migration
  def self.up
	  add_column :categories, :history, :text
  end

  def self.down
  	remove_column :categories, :history
  end
end
