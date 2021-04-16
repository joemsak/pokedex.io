class User < ApplicationRecord
  extend FriendlyId
  friendly_id :slug, use: [:slugged, :history]

  has_secure_password

  validates :email, uniqueness: true

end
