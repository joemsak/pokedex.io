FactoryBot.define do
  factory :pokemon_import do
    data { {} }
    url { "https://example.com/api/v2/pokemon/1" }
  end
end
