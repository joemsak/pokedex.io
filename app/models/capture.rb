class Capture < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  validates :user, uniqueness: { scope: :pokemon_id }
  validates :pokemon, uniqueness: { scope: :user_id }
end
