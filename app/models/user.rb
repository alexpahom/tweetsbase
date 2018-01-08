class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :messages
  before_save { self.email = email.downcase }

  has_secure_password

  email_regex = /[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+/
  validates :email, presence: true, format: { with: email_regex },
            length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }

  # returns the hash of the given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # remembers a user in db for use in persistent session
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_token).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
