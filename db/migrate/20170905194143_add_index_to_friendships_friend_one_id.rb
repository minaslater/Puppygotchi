class AddIndexToFriendshipsFriendOneId < ActiveRecord::Migration[5.0]
  def change
    add_index :friendships, [:friend_one_id, :friend_two_id], unique: true
  end
end
