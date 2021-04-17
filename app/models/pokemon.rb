class Pokemon < ApplicationRecord
  belongs_to :pokemon_import, inverse_of: :pokemon
end
