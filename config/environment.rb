
# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
ENV['RAILS_ENV'] ||= 'development'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.10' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.active_record.observers = :user_observer,:company_observer,:message_copy_observer,:title_observer

  # Add additional load paths for your own custom dirs
  config.load_paths += %W( #{RAILS_ROOT}/app/util )

  config.time_zone = 'Brasilia'

  config.gem "rack"
  config.gem "mysql2"
  config.gem "nokogiri"
  config.gem "htmlentities"
  config.gem "i18n_routing"
  config.gem "will_paginate", :version=>"2.3.14"

  config.i18n.load_path += Dir[Rails.root.join('my','locales', '*.{rb,yml}')]
  config.i18n.default_locale = "pt-BR"
  config.i18n.locale = "pt-BR"

end

ExceptionNotifier.exception_recipients = %w(suporte@celulaz.com.br)
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  "<span class='field_error'>#{html_tag}</span>".html_safe
end