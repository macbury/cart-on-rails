# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cart-on-rails_session',
  :secret      => 'd574b5124eb29057d7704d0b2540ecef19b3b6a5ef86430cdf65c0d4655b6b656a1ee129c3e9cf94258a92269abfb96cf17f35577ed15f36c3f1d510efb9c8e0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
