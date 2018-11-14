class CreatePics < ActiveRecord::Migration
  def self.up
    create_table :pics do |t|
      t.references :user
      t.references :coin
      t.references :contributor, :default => 0
      t.string :caption

      t.timestamps
    end
  end

  def self.down
    drop_table :pics
  end
end
