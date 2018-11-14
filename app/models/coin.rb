class Coin < ActiveRecord::Base
  # The main object type on the site. Organized by Category and created/owned by Users (usu. admin)
  
  belongs_to :category
  belongs_to :user
    
  has_many :pieces 
  has_many :collections, :through => :pieces
  has_many :pics

  default_scope order: "year, mint, feature"
  scope :random, lambda {|random| {:order => "RAND()", :limit => random }}
  scope :has_pics, joins(:pics).group('pics.coin_id').having("count(pics.coin_id) >= ?", 1)  # Those with any pics
	scope :chartable, includes(:pics, :category)

  validates_presence_of :year
  validates_presence_of :category

	#show no. pieces of current coin in collection
	def qty
		pieces.qty
	end

	# this coin appears in specified collection?
	def appears(collection_id)
		collections.find(collection_id)
	end

	#show first picture
	def main_pic
		pics.first.try(:url)
	end

  # For display of first two official pics on a page
	def official_pics(limit = 2)
		pics.official.limit(limit)
	end

  # Is coin owned by user? 
	def owned_by?(u)
    u && user == u  # Make sure u[ser] exists first
	end

  # Must be admin or owner to modify coin
	def editable_by?(u)
		u.admin? || owned_by?(u)
	end
  
### String representations for various displays ###
  def year_mint
    "#{year} #{mint}".rstrip
  end

  def year_mint_feature
    "#{year_mint} #{feature}".rstrip
  end

  def cat_year_mint
    "#{cat_name} #{year_mint}".rstrip
  end  

  def full_name    
    "#{cat_name}: #{name} #{year_mint_feature}".rstrip
  end

  def cat_name
  	category.name || ""
  end

  def full_name_with_parent
    [category.parent.try(:name), full_name].reject(&:empty?).join(": ")
  end

  def meta_description
    "Coin information about " + to_s
  end

  def meta_keywords
    cat_year_mint
  end  

  # Crumb path for page navigation, hierarchically through categories
  def crumb_path(*added)
    cpath = []
    cpath << [category.parent.name, category.parent] unless category.parent.blank?
    cpath << [category.name_dates, category]
    added.each {|node| cpath << node}
    cpath    
  end

  def to_s
    year_mint_feature
  end

  # For URLs, mainly
  def to_param
    "#{id}-#{cat_name.parameterize}-#{to_s.parameterize}"
  end  

end
