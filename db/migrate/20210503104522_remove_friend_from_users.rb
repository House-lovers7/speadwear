class RemoveFriendFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :friend, :boolean
  end
end
