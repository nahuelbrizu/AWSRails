# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :google_oauth2

  def google_oauth2
    Rails.logger.debug("Google OAuth Callback initiated")

    if request.env['omniauth.error'] == 'access_denied'
      Rails.logger.error("User denied access. Redirecting to sign-in...")
      redirect_to new_user_session_path, alert: 'Access was denied.'
      return
    end

    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        puts "User persisted. Redirecting..."
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        puts "User not persisted. Redirecting to sign-in..."
        session['google_data'] = request.env['omniauth.auth'].except(:extra)
        redirect_to new_user_session_path, alert: @user.errors.full_messages.join("\n")
      end
    rescue => e
      Rails.logger.error("Error during Google OAuth authentication: #{e.message}")
      redirect_to new_user_session_path, alert: 'An error occurred during authentication.'
    end
  end

  #def failure
  #  Rails.logger.error("Authentication failure")

  # redirect_to new_user_session_path
  #  end


  def passthru
   render status: 404, plain: "Not found. Authentication passthru."
 end
end
