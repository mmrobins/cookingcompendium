# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
require 'hodel_3000_compliant_logger'
config.logger = RALS_DEFAULT_LOGGER = Hodel3000CompliantLogger.new(config.log_path)

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

require 'smtp_tls'
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :domain         => 'mattrobinson.net',
  :authentication => :plain,
  :user_name      => 'sender@mattrobinson.net',
  :password       => 'cowsaredumb'
}
