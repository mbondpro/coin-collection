require 'uri'
require 'open-uri'
require 'nokogiri'

class Auction < ActiveResource::Base
  # eBay auctions API takes a call and returns a XML result
  # Auction_result contains all results & build instances of this class, each representing one auction. 

  # Fields: GalleryURL, BidCount, ConvertedCurrentPrice, TimeLeft, Title, ViewItemURLForNaturalSearch

  attr_accessor :xml  # The raw XML auction result

  # pass the item XML chunk to create a new item
  def initialize(xml)
    @xml = xml  # For the view
  end

  # parses the title element from the XML chunk
  def title
    (xml/:title).inner_html
  end

  # Make price readable
  def price
    sprintf("%.02f", (xml/:sellingStatus/:convertedCurrentPrice).inner_html)
  end
  
  # Show human-readable time
  def time_left
    convertTime((xml/:sellingStatus/:timeLeft).inner_html)
  end

  # Thumbnail
  def thumb
    (xml/:galleryURL).inner_html
  end

  # Link URL on eBay
  def item_url
    url = (xml/:viewItemURL).inner_html
  end

private

  # Converts raw time into more readable format
  #P0DT0H0M0S
  def convertTime(time)
    time.gsub!("P", "")

    if (time.match("0DT"))
      time.gsub!("0DT", "")
    else
      time.gsub!("DT", " Days ")
    end

    if (time.match("0H"))
      time.gsub!("0H", "")
    else
      time.gsub!("H", "h ")
    end

    time.gsub!("M", "m ")
    time.gsub!("S", "s ")
  end

end
