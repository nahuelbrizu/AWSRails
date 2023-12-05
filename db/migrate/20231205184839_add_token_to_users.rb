class AddTokenToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :token, :string
  end

  def down
    remove_column :users, :token
  end
end
