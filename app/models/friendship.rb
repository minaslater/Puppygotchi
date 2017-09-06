class Friendship < ApplicationRecord
  belongs_to :friend_one, foreign_key: "friend_one_id", class_name: "User"
  belongs_to :friend_two, foreign_key: "friend_two_id", class_name: "User"

  validate :friendship_combinations_cannot_duplicate
  validates :friend_one_id, uniqueness: { scope: :friend_two_id }
  validates :friend_two_id, uniqueness: { scope: :friend_one_id }

  def friendship_combinations_cannot_duplicate
    unless Friendship.where(friend_one_id: friend_two_id, friend_two_id: friend_one_id).empty?
      errors.add(:friend_one_id, "already has this friend.")
    end
  end
end
