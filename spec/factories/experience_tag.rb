FactoryBot.define do
  experience = Experience.new
  factory :experience_tag do
    title       { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 1..3) }
    period_id   { Faker::Number.within(range: 1..7) }
    tags        { Faker::Lorem.words.join(',') }
    stress      { Faker::Lorem.sentence }
    content     do
      experience.content = '<div>asdf</div>'
      experience.content
    end
  end
end
