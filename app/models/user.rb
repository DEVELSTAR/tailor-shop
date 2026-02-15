class User < ApplicationRecord
  has_secure_password
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  
  enum :role, { admin: 'admin', staff: 'staff' }, default: 'staff'
  
  def admin?
    role == 'admin'
  end
end
