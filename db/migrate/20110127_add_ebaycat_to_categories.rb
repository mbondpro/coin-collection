class AddEbaycatToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :ebaycat, :integer
  end

  def self.down
    remove_column :categories, :ebaycat
  end
end
