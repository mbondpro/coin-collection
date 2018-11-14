#encoding: utf-8

class AuctionResult
  # eBay auctions API takes a call and returns a XML result
  # Class contains all results & builds instances Auction.   
  # https://developer.ebay.com/DevZone/finding/CallRef/findItemsAdvanced.html

  require 'nokogiri'
  require 'open-uri'

  attr_reader :doc, :attempts, :terms, :auctions, :affiliate, :original_terms, :category

  NUM_EBAY_RESULTS = 20
  EBAY_TRACKING_PARTNER_CODE = 9   # 9 = eBay Partner Network
  EBAY_TRACKING_ID = 000000000     # Your eBay affiliate ID
  EBAY_DEVELOPER_ID = "" # Your ebay dev ID
  EBAY_DEFAULT_CAT = 253  # Default category to search. 253 = U.S. coins

  # Set up the search parameters
  # Args: coin instance, not logged in as admin?
  def initialize(coin, is_affiliate = true)
    @attempts = 0   # Counter
    @terms = coin.year_mint_feature  # Help specify a relevant search
    @original_terms = @terms  # Store it for subsequent searches
    @affiliate = is_affiliate
    @category = coin.category.ebaycat || EBAY_DEFAULT_CAT  # Coin's own category to narrow results

    # Searches, and if no results returned, widens the search, then again if still no results
    do_search  #full name as above. Most specific
    do_search(coin.year_mint) unless @auctions.any? # Widen to coin, year, and mint mark
    do_search(coin.year) unless @auctions.any?  # Widen again to just coin and year

  end

	def found?
		@auctions.any?
	end

  # Had to search multiple times due to no results?
	def multiple_search?
		@attempts > 1
	end

  private

  def parse
    # map is turning the array of XML objects into an array of auction Items
    @auctions = (@doc/:item).map { |auction_xml| Auction.new(auction_xml)  }
  end

  # Build the call to eBay
  def build_call(search_term)
    keywords = "#{search_term} -replica -copy -reproduction"  #minus means "not". Avoid replicas.
    host = "http://svcs.ebay.com/services/search/FindingService/v1"
    apicall = "OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.8.0&SECURITY-APPNAME=#{EBAY_DEVELOPER_ID}&REST-PAYLOAD&paginationInput.entriesPerPage=#{NUM_EBAY_RESULTS}&categoryId=#{@category}&sortOrder=EndTimeSoonest"
    apicall << "&keywords=#{keywords}"
    if @affiliate == true
      apicall << "&affiliate.networkId#{EBAY_TRACKING_PARTNER_CODE}&affiliate.trackingId=#{EBAY_TRACKING_ID}"
    end
    URI.escape("#{host}?#{apicall}")
  end

  # The main function of the class: build and perform the search and parse results
  def do_search(term = nil)
    @terms = term unless term.nil? #replace saved term with argument, if passed
    @attempts += 1
    @doc = Nokogiri::XML(open(build_call(@terms)))
    parse
  end

end
