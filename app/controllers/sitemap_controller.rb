class SitemapController < ApplicationController
  caches_page :sitemap
  
  def sitemap
    @categories = Category.find(:all, :order => :id, :limit => 1000)
    @coins = Coin.find(:all, :order => :id, :limit => 25000)
    @pics = Pic.find(:all, :order => :id, :limit => 20000)
    headers["Content-Type"] = "text/xml"
    # set last modified header to the date of the latest entry.
    headers["Last-Modified"] = @categories[0].updated_at.httpdate
    
    respond_to do |format|
      format.xml
    end
  end
end
