class AddImageRemoteUrlToPics < ActiveRecord::Migration
  def self.up 
    add_column :pics, :image_remote_url, :string
  end

  def self.down
    remove_column :pics, :image_remote_url
  end
end
