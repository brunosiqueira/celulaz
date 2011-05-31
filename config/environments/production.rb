# Settings specified here will take precedence over those in config/environment.rb
config.threadsafe!
# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true
DNS_PATH = "/etc/apache2/sites-available/"
SITE_URL = "www.celulaz.com.br"
EMAIL="agenciaz@celulaz.com.br"
SAC_EMAIL="contato@celulaz.com.br"

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false
config.action_view.cache_template_loading = true
