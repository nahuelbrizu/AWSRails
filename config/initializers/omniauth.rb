Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'],
           ENV['GOOGLE_CLIENT_SECRET'], {
             request_method: :post,
             redirect_uri: 'http://localhost:3003/users/auth/google_oauth2/callback'
           }
end