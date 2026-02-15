class Review < ApplicationRecord
  validates :reviewer_name, :rating, :comment, presence: true
  validates :rating, inclusion: { in: 1..5 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone, format: { with: /\A\+?[1-9]\d{1,14}\z/, message: "must be a valid phone number" }, allow_blank: true
  
  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }
  scope :recent, -> { order(created_at: :desc) }
  
  def self.average_rating
    approved.average(:rating)&.round(2) || 0
  end
  
  def self.rating_distribution
    approved.group(:rating).count
  end
end
