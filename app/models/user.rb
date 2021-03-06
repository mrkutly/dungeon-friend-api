class User < ApplicationRecord
  has_secure_password
  validates :name, length: { minimum: 4, maximum: 40 }, uniqueness: true
  validates :password, { confirmation: true, length: { minimum: 8, maximum: 40 } }
  validates :password_confirmation, presence: true

  has_many :characters
end
