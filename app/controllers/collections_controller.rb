class CollectionsController < ApplicationController
  # A User has a single Collection, which contains Coins

	require 'will_paginate/array'
  before_filter :require_login
  
  def show		
    @coins = current_user.collection.coins.uniq.paginate :page => params[:page]  #uniq; graded coins have sep. rows
    @piece = Piece.new

    respond_to do |format|
      format.html
    end
  end

end
