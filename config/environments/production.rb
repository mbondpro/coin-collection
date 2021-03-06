# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

config.action_controller.cache_store = :file_Store, "#{Rails.root}/public/cache"
#config.action_controller.cache_store = :mem_cache_store

#Bond
config.action_mailer.default_url_options = {:host => HOST}

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
#config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

config.action_mailer.delivery_method = :sendmail

# Compress JavaScripts and CSS
config.assets.compress = true
 
# Choose the compressors to use
# config.assets.js_compressor  = :uglifier
# config.assets.css_compressor = :yui
 
# Don't fallback to assets pipeline if a precompiled asset is missed
config.assets.compile = false  # Vulnerable if true!!!
 
# Generate digests for assets URLs.
config.assets.digest = true
 
# Defaults to Rails.root.join("public/assets")
# config.assets.manifest = YOUR_PATH
 
# Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
# config.assets.precompile += %w( search.js )


# Enable threaded mode
# config.threadsafe!
