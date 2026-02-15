class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy
  
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, allow_blank: true
  validates :phone, format: { with: /\A\+?[1-9]\d{1,14}\z/, message: "must be a valid phone number" }, uniqueness: true
  
  scope :recent, -> { order(created_at: :desc) }
  scope :active, -> { joins(:bookings).where.not(bookings: { status: 'cancelled' }).distinct }
  
  def full_name
    name
  end
  
  def total_bookings
    bookings.count
  end
  
  def recent_bookings(limit = 5)
    bookings.order(created_at: :desc).limit(limit)
  end
end
