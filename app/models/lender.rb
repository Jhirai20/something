class Lender < ActiveRecord::Base
  has_secure_password
  has_many :borrowers, through: :histories

  has_many :histories

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, confirmation: true
  before_save { email.downcase! }
end
