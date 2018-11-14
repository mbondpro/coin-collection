class ContributorsController < ApplicationController
  # Contributors are those who provide photos that need to be credited.

  before_filter :admin_auth
  
  def index
    @contributors = Contributor.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @contributor = Contributor.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @contributor = Contributor.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @contributor = Contributor.find(params[:id])
  end

  def create
    @contributor = Contributor.new(params[:contributor])

    respond_to do |format|
      if @contributor.save
        format.html { redirect_to(@contributor, :notice => 'Contributor was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @contributor = Contributor.find(params[:id])

    respond_to do |format|
      if @contributor.update_attributes(params[:contributor])
        format.html { redirect_to(@contributor, :notice => 'Contributor was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @contributor = Contributor.find(params[:id])
    @contributor.destroy

    respond_to do |format|
      format.html { redirect_to(contributors_url) }
    end
  end
end
