# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [:google_oauth2, :facebook]

  def google_oauth2
    @user = User.from_omniauthGoogle(auth)
    # if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    # else
      # New user, redirect to sign-up
    #   session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
    # redirect_to new_user_registration_url
    #end
  end

  def facebook
    @user = User.from_omniauthFacebook(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = auth.except("extra")
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to new_user_registration_url, alert: "Authentication failed, please try again."
  end

  private

  def auth
    auth = request.env['omniauth.auth']
  end

  private

  def skip_authenticity_token
    skip_before_action :verify_authenticity_token
  end
end
