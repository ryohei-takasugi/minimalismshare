FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    nickname              { Faker::Lorem.characters(number: 6) }
    dream                 { Faker::Number.within(range: 0..3) }
    region_id             { Faker::Number.within(range: 0..3) }
    climate_id            { Faker::Number.within(range: 0..3) }
    housemate_id          { Faker::Number.within(range: 0..3) }
    children_id           { Faker::Number.within(range: 0..3) }
    clean_status_id       { Faker::Number.within(range: 0..3) }
  end
end
