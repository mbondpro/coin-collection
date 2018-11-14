class CreateContributors < ActiveRecord::Migration
  def self.up
    create_table :contributors do |t|
      t.text :name
      t.text :url

      t.timestamps
    end
  end

  def self.down
    drop_table :contributors
  end
end
