class Friendship < ApplicationRecord
  belongs_to :friend_one, foreign_key: "friend_one_id", class_name: "User"
  belongs_to :friend_two, foreign_key: "friend_two_id", class_name: "User"
end
