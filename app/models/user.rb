class User < ApplicationRecord
  has_secure_password
  
  validates_presence_of :name, :address, :city, :state, :zipcode, :password_digest
  validates :email,
            uniqueness: true,
            presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  enum role: [:regular_user, :merchant_employee, :merchant_admin, :admin_user]
end
