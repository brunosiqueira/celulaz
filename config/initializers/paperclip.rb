if RAILS_ENV=="development"

  Paperclip.options[:image_magick_path] = '/opt/local/bin'
  Paperclip.options[:command_path] = '/opt/local/bin'
end