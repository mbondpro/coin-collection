class PicsController < ApplicationController
  # Displays coin images and allows pic uploads
  
  before_filter :require_login, :except => [:index, :show]
  before_filter :admin_auth, :only => [:preview]

  # Show all coin pics
  def index
    @coin = Coin.find(params[:coin_id])
    @pics = @coin.pics.paginate :page => params[:page]
    if (signed_in? && current_user.admin?)
      @pic = @coin.pics.build
    end

    respond_to do |format|
      format.html
    end
  end

  def show
    @coin = Coin.find(params[:coin_id])
    @pic = @coin.pics.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @coin = Coin.find(params[:coin_id])
    @pic = @coin.pics.build

    respond_to do |format|
      format.html
    end
  end

  def edit
    @coin = Coin.find(params[:coin_id])
    @pic = @coin.pics.find(params[:id])
  end

  # Upload pic and save its info
  def create
    @coin = Coin.find(params[:pic][:coin_id])
    params[:pic][:user_id] = current_user.id  # Credit pic to a user id
    @pic = @coin.pics.build(params[:pic])

    respond_to do |format|
      if @pic.save          
          format.html { 
            flash[:notice] = 'Pic was successfully created.'
            redirect_to(coin_pics_path(@coin))
          }
          format.js {
            render :update do |page|
              page.replace_html "status#{params[:pic][:page_url]}", "Uploaded"
            end
          }
      else
          format.html { render :action => "new" }
          format.js {
            render :update do |page|
              page.replace_html "status#{params[:pic][:page_url]}", "Failed"
            end
          }
      end
    end
  end

  def update
    @coin = Coin.find(params[:pic][:coin_id])
    @pic = Pic.find(params[:id])
    params[:pic][:user_id] = current_user.id

    respond_to do |format|
      # Can update a pic if user is an admin or the pic owner
      if (@pic.user_id == current_user.id) || current_user.admin?
        if @pic.update_attributes(params[:pic])
          flash[:notice] = 'Pic was successfully updated.'
          format.html { redirect_to(coin_pics_path(@coin)) }
        else
          format.html { render :action => "edit" }
        end
      else # Unauthorized
        flash[:error] = 'You cannot edit that picture because you do not own it.'
        format.html { redirect_to(coin_pics_url(@coin)) }
      end
    end
  end

  def destroy
    @coin = Coin.find(params[:coin_id])
    @pic = Pic.find(params[:id])

    # Can delete a pic if user is an admin or the pic owner
    if (@pic.user_id == current_user.id) || current_user.admin?
      @pic.destroy
    else # Unauthorized
      flash[:error] = 'You cannot delete that picture because you do not own it.'
      redirect_to(coin_pics_url(@coin))
    end

    respond_to do |format|
      format.html { redirect_to(coin_pics_url(@coin)) }
    end
  end

end
