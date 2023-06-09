class AddDefaultToFriendships < ActiveRecord::Migration[7.0]
  def change
    change_column_default :friendships, :status, "pending"
  end
end
