Coin3::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb
  
  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false
  
  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true
  
  # Show full error reports and disable caching
  #config.action_controller.consider_all_requests_local = true
  #config.action_view.debug_rjs                         = true
  
  config.action_controller.perform_caching             = false #true
  #config.action_controller.cache_store = :file_Store, "#{Rails.root}/public/cache"
  #config.action_controller.cache_store = :mem_cache_store, "localhost'
  
  config.active_support.deprecation = :log

  # Do not compress assets
  config.assets.compress = false
  config.assets.debug = false #true
  #config.assets.compile = true  # Vulnerable if true!!!
    
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

	# Raise exception on mass assignment protection for Active Record models
	config.active_record.mass_assignment_sanitizer = :strict
	 
	# Log the query plan for queries taking more than this (works
	# with SQLite, MySQL, and PostgreSQL)
	config.active_record.auto_explain_threshold_in_seconds = 0.5

	Paperclip.options[:command_path] = "/usr/local/bin/"
  
  #Clearance
  config.action_mailer.default_url_options = { :host => "localhost:3000"}
end