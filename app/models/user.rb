class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  has_secure_password
  has_secure_token :auth_token, length: 36

  validates :username, :email, uniqueness: true, presence: true
end
