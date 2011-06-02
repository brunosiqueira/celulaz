#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
I18n.default_locale = 'pt-BR'
I18n.locale = I18n.default_locale

LOCALES_DIRECTORY = "#{RAILS_ROOT}/config/locales/"

locale_path = "#{LOCALES_DIRECTORY}#{I18n.locale}.yml"

unless I18n.load_path.include? locale_path
  I18n.load_path << locale_path
  I18n.backend.send(:init_translations)
end


