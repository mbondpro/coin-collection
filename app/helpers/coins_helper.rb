module CoinsHelper
  # Show how many of this coin owned by user. The actual number of zero, instead of blank.
  def quantities(collection_id, coin)
    if coin.pieces.empty?
      "0"
    else
      coin.pieces.qty(collection_id)
    end
  end
end
