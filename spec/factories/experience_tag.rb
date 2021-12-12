FactoryBot.define do
  factory :experience_tag do
    title       { Faker::Lorem.characters(number: rand(1..100)) }
    category_id { Faker::Number.within(range: 1..3) }
    period_id   { Faker::Number.within(range: 1..7) }
    tags        { Faker::Lorem.words(number: rand(1..10)).join('、') }
    stress      { Faker::Lorem.characters(number: rand(1..100)) }
  end
end
