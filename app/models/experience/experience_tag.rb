class ExperienceTag
  include ActiveModel::Model
  attr_accessor :title, :category_id, :period_id, :tags, :stress, :user_id

  with_options presence: true do
    validates :title
    validates :category_id, numericality: { other_than: 0, message: 'を入力してください' }
    validates :period_id,   numericality: { other_than: 0, message: 'を入力してください' }
    validates :stress
    validates :content
    validates :user_id
  end

  def initialize(attributes = {})
    super
    @experience = set_experience
  end

  def save
    return false unless valid?

    experience = Experience.create(set_params_experience_tag)
    save_tags(tags, experience) unless tags.nil?
    experience
  end

  def update(experience)
    return false unless valid?

    experience.update(set_params_experience_tag)
    save_tags(tags, experience) unless tags.nil?
    delete_tag_relation(tags, experience)
    experience
  end

  def content
    @experience.content
  end

  def content=(data)
    @experience = set_experience
    @experience.content = data
    @content = @experience.content
  end

  private

  def save_tags(tags, experience)
    tags.split('、').each do |tag_name|
      tag_name = tag_name.gsub(' ', '')
      tag = Tag.where(name: tag_name).first_or_initialize
      tag.save
      save_tag_relation(experience, tag)
    end
  end

  def save_tag_relation(experience, tag)
    unless ExperienceTagRelation.find_by(experience_id: experience.id, tag_id: tag.id)
      ExperienceTagRelation.create(experience_id: experience.id, tag_id: tag.id)
    end
  end

  def delete_tag_relation(tags, experience)
    tag_relation = ExperienceTagRelation.where(experience_id: experience.id)
    regist_tags  = tag_relation.map { |r| r.tag.name }
    new_tags     = tags.split('、')
    diff = regist_tags - new_tags
    unless diff.nil?
      diff.each do |d|
        tag_id = Tag.find_by(name: d)
        ExperienceTagRelation.find_by(tag_id: tag_id).destroy
      end
    end
  end

  def set_experience
    Experience.new(set_params_experience_tag)
  end

  def set_params_experience_tag
    { title: title, category_id: category_id, period_id: period_id, content: @content, stress: stress, user_id: user_id }
  end
end
