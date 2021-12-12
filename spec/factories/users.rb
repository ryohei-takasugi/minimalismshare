FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    nickname              { Faker::Lorem.characters(number: 50) }
    dream                 { Faker::Lorem.characters(number: 50) }
    high_id               { Faker::Number.within(range: 0..9) }
    low_id                { Faker::Number.within(range: 0..9) }
    housemate_id          { Faker::Number.within(range: 0..3) }
    hobby_id              { Faker::Number.within(range: 0..3) }
    clean_status_id       { Faker::Number.within(range: 0..3) }
    range_with_store_id   { Faker::Number.within(range: 0..4) }
  end
end
