class AddFriendToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :friend, :boolean
  end
end
