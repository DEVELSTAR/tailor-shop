class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :booking_items, dependent: :destroy
  has_many :bookings, through: :booking_items
  
  validates :name, presence: true, uniqueness: { scope: :category_id }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 1000 }
  
  scope :featured, -> { where(featured: true) }
  scope :by_price, ->(direction = :asc) { order(price: direction) }
  scope :recent, -> { order(created_at: :desc) }
  
  def formatted_price
    "₹#{price.to_i}"
  end
  
  def price_range
    return formatted_price if description.blank? || !description.include?('Rs.')
    formatted_price
  end
  
  def featured_image
    image.attached? ? image : 'placeholder-product.jpg'
  end
end
