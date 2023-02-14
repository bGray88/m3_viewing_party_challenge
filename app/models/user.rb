class User < ApplicationRecord
  validates :email, :name, :password, presence: true
  validates :email, uniqueness: true

  has_secure_password

  enum role: { default: 0, admin: 1, manager: 2 }
end
