class User < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: [:slugged, :history]

  has_secure_password
  has_secure_token :auth_token, length: 36

  validates :email, uniqueness: true
end
