class Message < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :content, presence: true, length: { maximum: 140 }
end
