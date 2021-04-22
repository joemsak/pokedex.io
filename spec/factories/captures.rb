FactoryBot.define do
  factory :capture do
    user
    pokemon
    captured_at { Time.current }
  end
end
