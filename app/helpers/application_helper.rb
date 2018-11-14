# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # On home page?
  def home?
    @controller.controller_name == 'home'
  end
  
  # For adding page number to page title
  def page_no
	  params[:page] ? " Page #{params[:page]}" : ''
  end
  
  # For adding page number to page title
  def page_title_raw
  	@page_title ? "#{@page_title}#{page_no} | " : ''
  end  

  # Builds page title from elements
  def page_title        
    raw %(<title>#{page_title_raw}My USA Coin</title>)
  end

  # Builds meta tags from elements
  def meta(name, content)
    raw %(<meta name="#{name}" content="#{content}" />)
  end

  # Builds meta description from elements. Adds to description if it's a coin detail page.
  def meta_description
    description = ["Organize your U.S. coin collection with free software. "]
    if @coin and !@coin.new_record?
      description << [@coin.meta_description]
    end
    description << page_no
    raw description.join(" ")
  end

  # Builds meta keywords from elements. Adds relevant words if it's a coin detail page.
  def meta_keywords
    keywords = ["coin collecting, coin collecting software, free coin collecting software, coins, usa coins, us coins, coin photos"]
    if @coin and !@coin.new_record?
      keywords << [@coin.meta_keywords]
    end
    raw keywords.join(",")
  end

  # Builds a bold section header
  def title(title)
  	raw "<div class=\"titlebar\"><h2>#{title}</h2></div>"
  end

  # >>
  def carrot
    raw "&raquo;"
  end

  # Is current user an admin?
	def admin?
		current_user.try(:admin)
	end

  # Build UL containing all detected errors
	def error_list(obj)
		content_tag :ul do
			obj.errors.full_messages.collect {|err| concat(content_tag(:li, err))}
		end
	end

  # Build a URL if an image was contributed by someone who requires credit
	def contributor_link(pic)
		unless pic.contributor.blank?
			content_tag :span, class: "contributor" do
				link_to "By #{pic.contributor}", pic.contrib_link
			end
		end
	end

  #not in service
  def qty_graded(coin)
    if coin.pieces.empty?
      0
    else
      coin.pieces.qty(current_user.collection)
    end
  end

  # Shortcut
  def my_coll
    current_user.collection
  end

	def admin_email
		""  # Your email here
	end

end
