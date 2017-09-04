class Friendship < ApplicationRecord
  belongs_to :friend_one, foreign_key: "friend_one_id", class_name: "User"
  belongs_to :friend_two, foreign_key: "friend_two_id", class_name: "User"

  validates_uniqueness_of :friend_one_id, scope: :friend_two_id
  validates_uniqueness_of :friend_two_id, scope: :friend_one_id
end
