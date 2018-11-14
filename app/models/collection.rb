class Collection < ActiveRecord::Base
  # Users have Collections, which own Pieces (itself a doublet of a coin and grade)

  belongs_to :user
  has_many :pieces, :dependent => :destroy
  has_many :coins, :through => :pieces

  validates :user_id, presence: true

  # Get all the pieces corresponding to particular coin
	def coin_pieces(coin)
		pieces.where(coin_id: coin)
	end

  # Find by coin ID
	def has_coin(coin)
		coins.find(coin)
	end

  def meta_description
    to_s
  end

  def meta_keywords
    to_s
  end

  def to_s
    "Collection: " + user.username
  end

end
