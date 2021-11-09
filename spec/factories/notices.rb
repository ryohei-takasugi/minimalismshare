FactoryBot.define do
  factory :notice do
    message     { Faker::Lorem.sentence }
    url         { Faker::Internet.url(host: '127.0.0.1:3000') }
    read        { false }
    association :user
  end
end
