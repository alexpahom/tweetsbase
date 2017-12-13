class User < ApplicationRecord
  # has_secure_password
  email_regex = /[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+/
  validates :email, presence: true, uniqueness: true, format: { with: email_regex }
  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
end
