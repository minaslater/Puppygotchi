class User < ApplicationRecord
  has_many :puppies, dependent: :destroy

  has_many :friend_ones, through: :friendship_one, source: :friend_one
  has_many :friendship_one, foreign_key: :friend_two_id, class_name: "Friendship", dependent: :destroy

  has_many :friend_twos, through: :friendship_two, source: :friend_two
  has_many :friendship_two, foreign_key: :friend_one_id, class_name: "Friendship", dependent: :destroy

  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def self.login(email, password)
    @user = User.find_by(email: email)
    @user if @user && @user.authenticate(password)
  end

  def friends
    friend_ones + friend_twos
  end

  def make_friends_with(user)
    friendship_one.create(friend_one_id: user.id)
  end

  def delete_friend(user)
    friendships = Friendship.where(friend_one_id: id, friend_two_id: user.id).or(Friendship.where(friend_one_id: user.id, friend_two_id: id))
    friendships.delete_all if friendships.any?
  end

  def verify_friendship?(user)
    friendships = Friendship.where(friend_one_id: id, friend_two_id: user.id).or(Friendship.where(friend_one_id: user.id, friend_two_id: id))
    friendships.any?
  end
end
