class CreatePieces < ActiveRecord::Migration
  def self.up
    create_table :pieces do |t|
      t.references :collection
      t.references :coin
      t.integer :quantity, :default => 0
      t.string  :grade
      t.string  :note

      t.timestamps
    end
  end

  def self.down
    drop_table :pieces
  end
end
