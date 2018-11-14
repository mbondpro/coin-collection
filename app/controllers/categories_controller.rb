class CategoriesController < ApplicationController
  # Categories (Lincoln cents, quarters, etc.) contain Coins
  # They change infrequently but are nested, so they require intensive DB pulls
  # and should therefore be cached.

  before_filter :admin_auth, :except => [:show]
  cache_sweeper :category_sweeper, :only => [:create, :update, :destroy]
  
  def index
    @categories = Category.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|      
			if @category.header_only?  # Has neither a parent above nor coins below
				format.html { render :action => "show" }				
			else  # Has coins, so show them
				format.html { redirect_to(category_coins_path(@category)) }
			end
    end
  end

  def new
    @category = Category.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    @category.user_id = current_user.id
    @category.official = true if current_user.admin?  # 'Official' means created by admin

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(@category) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @category = Category.find(params[:id])
    raise if @category.user_id != current_user.id && !current_user.admin?  # Unauthorized
    @category.official = true if current_user.admin?  # 'Official' means created by admin

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(categories_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  rescue
    flash[:error] = 'You do not have permission to edit this category.'
    redirect_to(categories_path)
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    if @category.coins.count == 0
      @category.destroy
    else
      raise "This category is not empty, so you cannot delete it."
    end

    respond_to do |format|
      flash[:notice] = 'Category was successfully deleted.'
      format.html { redirect_to(categories_url) }
    end
  rescue
    flash[:error] = 'Either the category was not found or you do not have permission to delete it.'
    redirect_to(category_path)
  end
end
