class User < ApplicationRecord
  # has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /A.+@.+z/ }
  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
end
