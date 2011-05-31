# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false
config.cache_store = :mem_cache_store, '127.0.0.1:11211', {:namespace => "dev"}
DNS_PATH = ""
SITE_URL = "201.37.245.179:3000"
EMAIL="bsiqueira@suaempreza.com.br"
SAC_EMAIL="bsiqueira@suaempreza.com.br"
# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

config.action_mailer.perform_deliveries = false
# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

#config.gem 'bullet', :source => 'http://gemcutter.org'
#config.after_initialize do
#  Bullet.enable = true
#  Bullet.alert = true
#  Bullet.bullet_logger = true
#  Bullet.console = true
#  Bullet.growl = true
#  Bullet.rails_logger = true
#  Bullet.disable_browser_cache = true
#end

config.middleware.use "Rack::Bug",
  :secret_key => "bunda"
  
config.action_mailer.default_url_options = { :host => "localhost:3000" }