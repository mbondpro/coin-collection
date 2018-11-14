class User < ActiveRecord::Base
  include Clearance::User
 
	before_validation :build_collection

  has_many :categories
  has_many :pics
  has_many :coins  # Refers to coins created, not coins in the collection, which is below
  has_one :collection, :dependent => :destroy  #collection only, not created
  
  validates :username, presence: true, uniqueness: true

	def pieces(coin)
		collection.coin_pieces(coin) 
	end

  def to_param
    "#{id}-#{self.username.parameterize}"
  end

end
