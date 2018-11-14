class AdminController < ApplicationController

  before_filter :admin_auth # Check if admin

  def index
  end

  def users
  end

  # Check pic URLs saved in database against the actual existence of the pics in the file system
  def pic_audit
    @pics = Array.new
    Coin.has_pics(1).each do |c|
      c.pics.each do |pic|
        unless FileTest.exists?(Rails.root.join("public", self.pic.url.split('?').first)) then 
          @pics << pic
        end
      end
    end

    @pics
  end
 
end
