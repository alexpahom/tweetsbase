class User < ApplicationRecord
  # has_secure_password
  has_many :messages
  # accepts_nested_attributes_for :messages

  email_regex = /[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+/
  validates :email, presence: true, format: { with: email_regex },
            length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
end
