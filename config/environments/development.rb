Slideonline::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
	
  config.cache_classes = false 

	#sets a reasonable default for maximum cache entry lifetime,enables compression for large values 
	config.perform_caching = true
	config.action_controller.perform_caching = true
	config.cache_store = :dalli_store, 'localhost:11211', { :expires_in => 1.day, :compress => true }

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.action_mailer.default_url_options = { :host => '10.0.2.136:3000' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method =:smtp
  config.action_mailer.smtp_settings = {
    :address=> "smtp.126.com",
    :port=> 25,
    :domain=> "126.com",
    :authentication=> :login,
    :user_name=> "tagslide@126.com",
    :password=> "xlw123" 
  }
end
