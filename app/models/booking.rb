class Booking < ApplicationRecord
  belongs_to :customer
  has_many :booking_items, dependent: :destroy
  has_many :products, through: :booking_items
  accepts_nested_attributes_for :booking_items, allow_destroy: true
  
  validates :status, presence: true
  validates :booking_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  enum :status, { 
    pending: 'pending', 
    confirmed: 'confirmed', 
    in_progress: 'in_progress', 
    ready: 'ready', 
    completed: 'completed', 
    cancelled: 'cancelled' 
  }, default: 'pending'
  
  scope :recent, -> { order(created_at: :desc) }
  scope :active, -> { where(status: [:pending, :confirmed, :in_progress, :ready]) }
  scope :completed_today, -> { where(status: :completed, updated_at: Date.current.all_day) }
  
  def calculate_total
    booking_items.sum(&:total_price)
  end
  
  def update_total!
    update!(total_price: calculate_total)
  end
  
  def status_badge_class
    case status
    when 'pending' then 'warning'
    when 'confirmed' then 'info'
    when 'in_progress' then 'primary'
    when 'ready' then 'success'
    when 'completed' then 'success'
    when 'cancelled' then 'danger'
    end
  end
end
