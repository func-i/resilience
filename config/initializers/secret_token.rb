# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Resilience::Application.config.secret_key_base = '1c44c3c50cabc85339fb5dc9dc8018b88248da18a57e6b9c5429a385b34397e57f2a5af431fc3b730db93a8739090fc220e175da6692c369e9d0a783bb43e6d1'
