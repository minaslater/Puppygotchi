class User < ApplicationRecord
  has_many :puppies, dependent: :destroy

  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  def self.login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      @user
    else
      false
    end
  end
end
