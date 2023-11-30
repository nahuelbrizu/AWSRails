
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  # Facebook
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']

  # Twitter
  # provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']

  # Google
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']

  # Add other providers here as needed
end
