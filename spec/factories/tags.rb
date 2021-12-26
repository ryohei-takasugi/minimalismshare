FactoryBot.define do
  factory :tag do
    name  { "試験_#{Faker::Lorem.word}" }
  end
end
