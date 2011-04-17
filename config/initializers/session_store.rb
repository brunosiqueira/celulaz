# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key => '_sua_empreza_session',
  :secret      => '1dc05b98629ef250495a68f0e5e2245663fe2fbc9c7726e52017990ec9ba5461a4c7381111f6e76ed09f9740b655044ef016faea2baf6307631dc8237a1c412d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
