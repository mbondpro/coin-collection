class EbayController < ApplicationController
  # Controls access to eBay auctions through the eBay Product API, 
  # so relevant auctions can be displayed in the page.

	# Return list of auctions for specified coin
  def index
    @coin = Coin.find(params[:coin_id])
    @auction_result = AuctionResult.new(@coin, affiliate_link?)  

		respond_to do |format|
			format.js { render partial: 'auctions' }
		end
  end

  private

  # Skip affiliate link if admin, to avoid false clickthroughs
  def affiliate_link?
    !current_user.try(:admin?)
  end

end
