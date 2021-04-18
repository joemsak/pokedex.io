class Pokemon < ApplicationRecord
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
end
