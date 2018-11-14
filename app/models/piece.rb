class Piece < ActiveRecord::Base
  # A unique Piece is a coin/grade combination that gets saved with a quantity to a Collection
  # Ex: Coin# 345, Grade = AU-50, Qty = 3. The coin/grade makes it a unique row.

  belongs_to :collection
  belongs_to :coin
  
	default_scope order("RIGHT(grade, 2), grade") # Order by numerical digits of the grade
	scope :zero, where(quantity: 0)
	scope :single, where(quantity: 1)
	scope :nonzero, where('quantity > 0')
	scope :graded, where("grade is not null")
	scope :ungraded, where("grade is null")

  # Can't have negative number of coins
	validates :quantity, numericality: { greater_than_or_equal_to: 0, \
		message: "in this grade cannot be less than zero. " + \
			"You must be on the coin's detail page to subtract graded coins." }

	# Quantity across all grades
  def self.qty
		sum(:quantity)
	end

  # Don't allow blank grades for display; say "None"
  def grade_or_blank
    grade || "None"
  end

	# Just the grade digits. Format is 'AU-55'
	def grade_no
		grade.nil? ? 0 : grade.split("-").last
	end

  # Increase or decrease quantity for a Piece. Add sign (optionally) to subtract.
	def bump(sign = '+')
		sign == '-' ? self.quantity -= 1 : self.quantity += 1
	end

	def owned_by?(u)
		collection == u.collection
	end

	def editable_by?(u)
		u.admin? || owned_by?(u)
	end

  GRADES =
    %w{ None
        AG-03
        G-04
        VG-08
				F-12
				VF-20
				VF-30
				EF-40
				EF-45
				AU-50
				AU-55
				MS-60
				MS-63
				MS-65
				MS-70
				PF-60
				PF-63
				PF-65
    }

end
