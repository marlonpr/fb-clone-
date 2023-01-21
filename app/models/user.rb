class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, foreign_key: :sender_id
  has_many :received_friendships, class_name: 'Friendship', foreign_key: :receiver_id
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one :avatar, through: :profile
  has_one :bio, through: :profile
  has_one :location, through: :profile
  has_one :name, through: :profile
end
