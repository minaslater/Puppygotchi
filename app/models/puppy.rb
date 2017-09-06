class Puppy < ApplicationRecord
  belongs_to :users

  validates :name, length: { maximum: 12 }, presence: true
end
