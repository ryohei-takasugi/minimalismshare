FactoryBot.define do
  factory :experience_tag do
    title       { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 1..3) }
    period_id   { Faker::Number.within(range: 1..7) }
    tags        { Faker::Lorem.words.join('、') }
    stress      { Faker::Lorem.sentence }
  end
end
