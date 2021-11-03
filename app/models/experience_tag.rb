class ExperienceTag
  include ActiveModel::Model
  attr_accessor :title, :category_id, :period_id, :tags, :stress, :user_id

  # attr_writer :content

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

    experience = Experience.create(title: title, category_id: category_id, period_id: period_id, content: content,
                                   stress: stress, user_id: user_id)
    unless tags.nil?
      tags.split(',').each do |tag_name|
        tag_name = tag_name.gsub(' ', '')
        tag = Tag.where(name: tag_name).first_or_initialize
        tag.save
        ExperienceTagRelation.create(experience_id: experience.id, tag_id: tag.id)
      end
    end
  end

  def update(experience)
    return false unless valid?

    experience.update(title: title, category_id: category_id, period_id: period_id, content: content,
                                  stress: stress, user_id: user_id)
    unless tags.nil?
      tags.split(',').each do |tag_name|
        tag_name = tag_name.gsub(' ', '')
        tag = Tag.where(name: tag_name).first_or_initialize
        tag.save
        unless ExperienceTagRelation.find_by(experience_id: experience.id, tag_id: tag.id)
          ExperienceTagRelation.create(experience_id: experience.id, tag_id: tag.id)
        end
      end
    end
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

  def set_experience
    Experience.new(title: title, category_id: category_id, period_id: period_id, content: @content, stress: stress, user_id: user_id)
  end
end
