class Puppy < ApplicationRecord
  belongs_to :user

  validates :name, length: { maximum: 12 }
end
