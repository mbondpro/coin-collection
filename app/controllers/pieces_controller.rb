class PiecesController < ApplicationController
  # A Collection contains Pieces, which are a combination of: a Coin (id) and a grade. 
  # The quantity owned for each Piece is stored as a DB row.
  # Example: a Piece is coin ID 345, Grade = VF-20. Then the quantity = 4 or whatever.
  # If a different grade is used, it is saved as a different piece, since a unique Piece is a Coin/Grade combo.

  before_filter :require_login  # Collection functions, so must be logged in
	before_filter :get_coin # Grab coin based on ID

	# Create a new Piece or update an existing Piece if it exists.
	def create
		set_grade # Handle grade vs. no grade; private method below

    # If this coin/grade combo exists as a Piece in Collection, adjust the quantity; else build a new Piece
    get_existing_piece.nil? ?	build_piece :	@piece.bump(params[:sign])

    respond_to do |format|
			if @piece.save
				format.js {
					if coin_list?  # If there is already a collection list on page, then update DOM
						render 'coin_pg'
					else  # Add a collection table for this coin
						@pieces = current_user.pieces(@coin).nonzero  
						render 'create'
					end
				}
			else
				render 'error'					
			end
    end

		rescue
			render 'error'			
	end

  # Respond to a quantity change
	def update
    @piece = current_user.collection.pieces.find(params[:id])		
		@piece.bump(params[:sign])  # Adjusts by 1, sign = + or -

    respond_to do |format|
			if @piece.save 
				format.js
			else
				format.js { render 'error', :locals => { piece: @piece } }
			end
    end

		rescue
			render 'error'			
	end

private

  # Grab coin based on ID
	def get_coin
		@coin = Coin.find(params[:coin_id])
	end

	# If a Piece appears in params and is anything except "None", then set it as the grade.
  # Converts a Piece without a grade ("None") to nil
	def set_grade
		if params[:piece] && params[:piece][:grade] != "None"
			@grade = params[:piece][:grade]
		end
	end

  # Provided a collection id, coin id, and grade, try to find an existing Piece
	def get_existing_piece
    logger.info "getting existing piece"
		@piece = @coin.pieces.where(collection_id: current_user.collection, grade: @grade).first
	end

  # Provided a collection id, coin id, and grade, build a new Piece
	def build_piece
    logger.info "building piece"
		@piece = @coin.pieces.single.new(params[:piece]) do |p|
			p.collection_id = current_user.collection.id
			p.grade = @grade
		end
	end

  # Is there a coin list on the page? 
	def coin_list?
		params[:page] == 'coin'
	end

