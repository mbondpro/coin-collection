require 'open-uri'
require 'nokogiri'

class Pic < ActiveRecord::Base
  # A Coin picture

  belongs_to :user
  belongs_to :coin
  belongs_to :contributor

  attr_accessor :image_url, :page_url

  scope :official, where('user_id = 1')		#main admin
	scope :guest, where('user_id > 1') #everyone else
	scope :for_coin, lambda {|c| where('coin_id = ?', c) }

  def found?
    FileTest.file?(self.pic.path.split('?').first) 		
  end

	def default_caption
		caption || "Coin Picture for #{coin.full_name_with_parent}"
	end

	def contrib_link
		contributor.try(:link)
	end

  def pic_id
    coin_id
  end

	def owned_by?(u)
		user == u
	end

	def to_s
		url
	end

	def url
		pic.url
	end

	def path
		pic.path
	end

  #Paperclip - start
	has_attached_file :pic,
		:styles => {
			:thumb => "200x150>",
			:medium => "700x700>" },
		:default_style => :thumb,
    :path => ":rails_root/public/system/:attachment/:coin/:user/:style/:basename.:extension",
    :url => "/system/:attachment/:coin/:user/:style/:basename.:extension"

  Paperclip.interpolates :coin do |attachment, style| 
		attachment.instance.coin_id
	end
  Paperclip.interpolates :user do |attachment, style| 
		attachment.instance.user_id
	end
  
  before_post_process :randomize_file_name

  # Avoid name collisions via SecureRandom string extension
  def randomize_file_name
    extension = File.extname(pic_file_name).downcase  #pic_file_name is found on model
    self.pic.instance_write(:file_name, "coin-#{caption.parameterize}-#{SecureRandom.hex(4)}#{extension}")
  end

  # Restrict file types
  validates_attachment_content_type :pic,
    :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']

  validates_attachment_size :pic, :less_than => 10.megabytes
  #Paperclip - end

end
