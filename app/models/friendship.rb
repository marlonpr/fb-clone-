class Friendship < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  enum status: [:pending, :accepted]
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  scope :pending, ->(user_id) { where(receiver_id: user_id, status: 0) }
  scope :accepted, ->(user_id) { where(receiver_id: user_id, status: 1) }
  scope :accepted_send, ->(user_id) { where(sender_id: user_id, status: 1) }
end
