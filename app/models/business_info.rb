class BusinessInfo < ApplicationRecord
  validates :name, :address, presence: true
end
