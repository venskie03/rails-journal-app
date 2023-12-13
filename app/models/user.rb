require 'bcrypt'
class User < ApplicationRecord
  has_many :categories
  validates :email, uniqueness: true
  has_secure_password
end
