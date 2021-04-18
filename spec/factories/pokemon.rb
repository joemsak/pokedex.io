FactoryBot.define do
  factory :pokemon do
    pokemon_import

    sequence(:name) { |n| "name#{n}" }
    sequence(:external_id) { |n| n }
    sequence(:image_url) { |n| "https://example.com/#{n}/image.jpg" }

    imported_at { Time.current }
  end
end
