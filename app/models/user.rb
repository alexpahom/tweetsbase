class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :messages
  before_save { self.email = email.downcase }
  before_create :create_activation_digest

  has_secure_password

  email_regex = /[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+/
  validates :email, presence: true, format: { with: email_regex },
            length: { maximum: 40 }, uniqueness: { case_sensitive: false }
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

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_send_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_send_at < 2.hours.ago
  end
end
