# frozen_string_literal: true

Devise.setup do |config|

  config.omniauth :facebook, '1487864018644257', 'd32565357bdef6f00a67a54d1f8f31cf', callback_url: "http://localhost:3003/users/auth/facebook/callback"

  Rails.application.config.middleware.use OmniAuth::Builder do
    OmniAuth.config.silence_get_warning = true

    provider :google_oauth2, '772918967244-k93kvjnb41dfhnp477vo2hgmafvi29i1.apps.googleusercontent.com',
             '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',
             {
               redirect_uri: 'http://localhost:3003/users/auth/google_oauth2/callback',
               scope: 'email, profile, http://gdata.youtube.com',
               prompt: 'select_account',
               image_aspect_ratio: 'square',
               image_size: 50
             }
  end

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

end
