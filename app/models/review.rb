class Review < ApplicationRecord
  validates :reviewer_name, :rating, :comment, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
