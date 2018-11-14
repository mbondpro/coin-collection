class Contributor < ActiveRecord::Base
  # Contributors are credited for pics

  has_many :pics

  def link
  	"http://#{url}/"
  end

  def to_s
    name
  end
  
end
