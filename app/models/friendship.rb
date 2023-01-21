class Friendship < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  enum status: [:pending, :accepted, :decline]
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  scope :pending, ->(user_id) { where(receiver_id: user_id, status: 0) }
  scope :accepted, ->(user_id) { where(receiver_id: user_id, status: 1) }
  scope :decline, ->(user_id) { where(receiver_id: user_id, status: 2) }
  
end
