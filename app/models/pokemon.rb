class Pokemon < ApplicationRecord
  self.per_page = 20 # Pokeapi.co default is currently 20

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :pokemon_import

  belongs_to :import,
    class_name: "PokemonImport",
    foreign_key: :pokemon_import_id,
    required: false

  validates :name, :external_id, :image_url,
    presence: true,
    uniqueness: true

  validates :imported_at, presence: true

  has_many :captures
  has_many :users, through: :captures
end
