FactoryBot.define do
  factory :pokemon do
    sequence(:name) { |n| "name#{n}" }
    sequence(:external_id) { |n| n }
    sequence(:image_url) { |n| "https://example.com/#{n}/image.jpg" }
  end
end
