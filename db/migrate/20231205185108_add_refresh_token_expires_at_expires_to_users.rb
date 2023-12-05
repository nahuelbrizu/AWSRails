class AddRefreshTokenExpiresAtExpiresToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :refresh_token, :string
    add_column :users, :expires_at, :datetime
    add_column :users, :expires, :boolean
  end
end
