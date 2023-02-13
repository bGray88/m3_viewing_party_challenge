class User < ApplicationRecord
  validates :email, :name, :password, presence: true
  validates :email, uniqueness: true

  has_secure_password
end
