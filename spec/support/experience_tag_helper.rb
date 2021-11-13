module ExperienceTagHelper
  def create_experience_tag(user_model:)
    experience_tag = FactoryBot.build(:experience_tag)
    experience_tag.content = Faker::Lorem.sentence
    experience_tag.user_id = user_model.id
    experience_tag = experience_tag.save
    experience_tag
  end
  def build_experience_tag(user_model:)
    experience_tag = FactoryBot.build(:experience_tag)
    experience_tag.content = Faker::Lorem.sentence
    experience_tag.user_id = user_model.id
    experience_tag
  end
end