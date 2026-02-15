class Gallery < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  
  validates :title, presence: true
  validates :description, length: { maximum: 500 }
  
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_category, ->(category) { where(category: category) }
  
  def featured_image_url
    if image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    else
      'placeholder-gallery.jpg'
    end
  end
  
  def category_name
    category&.name || 'Uncategorized'
  end
end
