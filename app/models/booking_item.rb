class BookingItem < ApplicationRecord
  belongs_to :booking
  belongs_to :product
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  def total_price
    price * quantity
  end
  
  def product_name
    product&.name || 'Unknown Product'
  end
  
  def formatted_price
    "₹#{price.to_i}"
  end
  
  def formatted_total
    "₹#{total_price.to_i}"
  end
end
