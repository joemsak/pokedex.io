class Pokemon < ApplicationRecord
  belongs_to :pokemon_import

  belongs_to :import,
    class_name: "PokemonImport",
    foreign_key: :pokemon_import_id
end
