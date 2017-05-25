class Puppy < ApplicationRecord
  validates :name, length: { maximum: 12 }
end
