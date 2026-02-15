class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :galleries, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  validates :description, length: { maximum: 500 }
  
  scope :with_products, -> { joins(:products).distinct }
  scope :ordered, -> { order(name: :asc) }
  
  def product_count
    products.count
  end
  
  def featured_products(limit = 3)
    products.limit(limit)
  end
end
