FactoryBot.define do
  factory :experience_like do
    like        { [true, false].sample }
    imitate     { [true, false].sample }
    experience
    user
  end
end
