FactoryBot.define do
  factory :experience do
    title       { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 1..3) }
    period_id   { Faker::Number.within(range: 1..7) }
    stress      { Faker::Lorem.sentence }
    association :user
  end
end
