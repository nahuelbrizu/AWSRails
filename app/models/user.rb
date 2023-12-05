class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauthFacebook(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image


    end
  end



  def self.from_omniauthGoogle(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      existing_user = find_by(email: auth.info.email)

      if existing_user
        user = existing_user
      else
        user.email = auth.info.email
      end

      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
      user.provider = auth.provider
      user.uid = auth.uid
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token if auth.credentials.refresh_token.present?
      user.expires_at = auth.credentials.expires_at if auth.credentials.expires_at.present?
      user.expires = auth.credentials.expires if auth.credentials.expires.present?

      if user.new_record? || user.changed?
        user.save # Disable validations for this save
      end
    end
  rescue StandardError => e
    Rails.logger.error("Error in from_omniauthGoogle: #{e.message}")
    nil
  end


end
