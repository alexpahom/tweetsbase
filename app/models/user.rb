class User < ApplicationRecord
  has_many :messages
  before_save { self.email = email.downcase }

  has_secure_password

  email_regex = /[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+/
  validates :email, presence: true, format: { with: email_regex },
            length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
  validates :password, length: { minimum: 6 }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
