class CoinsController < ApplicationController
  # Coins are the heart of the site and collections. 
  # They belong to Categories and often appear in Category or Collection lists, or individually.

  before_filter :admin_auth, except: [:index, :show]  # Would need to unrestrict for users to make coins
	before_filter :store_location, except: [:edit, :update, :destroy]  # Nav aid
	before_filter :get_editable_coin, only: [:edit, :update, :destroy] # Check permissions before these actions
  
  def index
    @category = Category.find(params[:category_id])
	  @coins = @category.coins.chartable.paginate :page => params[:page]
    @piece = Piece.new if signed_in?

    respond_to do |format|
      format.html
    end
  end

  def show
    raise if (params[:id]=='auctions')  #remote only; crawler-averse
    @coin = Coin.find(params[:id])    
    @pics = @coin.official_pics

		if signed_in?  # Prep to manage collection
    	@piece = Piece.new 
			@pieces = current_user.collection.coin_pieces(@coin).nonzero
     	@user_pics = current_user.pics.guest.for_coin(@coin)
		end

    respond_to do |format|
      format.html
    end
  rescue
  #  render :file => Rails.root.join("public", "403.html"), :status => 403 
  end

  def new
    @categories = Category.sorted_tree  # Nested
    @coin = Coin.new

    respond_to do |format|
      format.html
    end
  end

  def edit
		@categories = Category.sorted_tree  # Nested

    respond_to do |format|
      format.html
    end

  end

  def create
    @categories = Category.all
    params[:coin][:user_id] = current_user.id
    @coin = Coin.new(params[:coin])

    respond_to do |format|
      if @coin.save
        flash[:notice] = 'Coin was successfully created.'
        format.html { redirect_to(@coin) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @coin.update_attributes(params[:coin])
        flash[:notice] = 'Coin was successfully updated.'
        format.html { redirect_to(@coin) }
      else
        format.html { render :action => "edit" }
      end
    end

  end

  def destroy
    @coin.destroy

    respond_to do |format|
      flash[:notice] = 'Coin was successfully deleted.'
      format.html { redirect_to(coins_url) }
    end

  end

private

	# find coin & ensure it's owned by user or admin
	def get_editable_coin		
		@coin = Coin.find(params[:id])
		unless @coin.editable_by?(current_user)
	    flash[:error] = "You do not have permission to modify the coin."
    	redirect_back_or(root_path) #should be stored already
		end
	end

end
