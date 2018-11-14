require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(:default, Rails.env) 
  #Bundler.require *Rails.groups(:assets => %w(development test))   #Rails 3.0 only
end

module Coin3
  class Application < Rails::Application
    #config.autoload_paths += [config.root.join('lib')]
    config.encoding = 'utf-8'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  
    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{RAILS_ROOT}/extras )
  
    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
  
    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  
		config.action_view.javascript_expansions = { :defaults => %w(jquery_ujs) }
  
    # Enable the asset pipeline
    config.assets.enabled = true
    
    config.filter_parameters += [:password]

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    
    config.autoload_paths += %W(#{config.root}/app/sweepers")
    #Rails::VendorGemSourceIndex.silence_spec_warnings=true
  
  end
end

