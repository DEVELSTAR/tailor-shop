class BusinessInfo < ApplicationRecord
  validates :name, :address, :phone, presence: true
  validates :phone, format: { with: /\A\+?[1-9]\d{1,14}\z/, message: "must be a valid phone number" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  
  has_one_attached :logo
  has_many_attached :gallery_images
  
  def social_links
    @social_links ||= {
      facebook: facebook_url,
      instagram: instagram_url,
      whatsapp: whatsapp_number
    }.compact
  end
end
