class Category < ActiveRecord::Base
  # Categories contain Coins and can be nested

	include ActsAsTree  

	belongs_to :user
  has_many :coins

  acts_as_tree  :order => 'position ASC, years ASC'  # Position is manually defined in DB
  default_scope :order => 'position ASC, years ASC'
 
  # Hierarchically sorts by position and years (category's time frame)
  def self.sorted_tree
  	tree = []
  	self.top_levels.map do |node| 
  		tree.push([node.full_name_dates, node.parent_id, node.id])
  		node.children.each {|ch| tree.push([ch.full_name_dates, node.parent_id, ch.id])}
  	end
  	tree
  end

  # All the first-level nodes without parents
	def self.top_levels
		where('parent_id is null').order(:position)
	end

  # Root node?
	def top?
		parent.nil?
	end

  # Some categories are only headers for lower categories, without their own coins
	def header_only?
		coins.empty? && parent.nil?
	end

  # Parent's name, if exists
  def par_name
    parent.try(:name) || ""
  end

### String representations for display

  def dates
  	"(#{years})".sub("()","")
  end

  def name_dates
    "#{name} #{dates}".strip
  end

  # Combine parent name and own name, if they exist
  def par_self_name
		[par_name, name].reject(&:empty?).join(": ")
  end

  def full_name_dates
    "#{par_self_name} #{dates}".strip
  end

  def meta_description
    "List of coins for " + to_s
  end

  def meta_keywords
    name_dates
  end

  def to_s
    full_name_dates
  end

  # For URLs, mainly
  def to_param
    "#{id}-#{name.parameterize}"
  end

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :parent_id
  validate :own_parent  # Prevent being one's own parent
  validate :parent_exists # Ensure existence of parent before assigning

  private

  def own_parent
    errors[:base] << "A category cannot be its own parent." if id == parent_id
  end

  def parent_exists
    errors[:base] << "The parent category does not exist." if Category.find_by_id(parent_id).nil? 
  end
  
end
