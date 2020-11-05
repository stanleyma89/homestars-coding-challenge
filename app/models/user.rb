class User < ApplicationRecord
  has_many :messages
  has_many :user_channels
  has_many :channels, through: :user_channels
  validates :username, presence: true
  validates_uniqueness_of :username
end
