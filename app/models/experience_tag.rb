class ExperienceTag
  include ActiveModel::Model
  attr_accessor :title, :category_id, :period_id, :tags, :user_id
  attr_writer :content

  with_options presence: true do
    validates :title
    validates :category_id, numericality: { other_than: 0, message: "を入力してください" }
    validates :period_id,   numericality: { other_than: 0, message: "を入力してください" }
    validates :content
  end

  def initialize(attributes={})
    super
    set_experience
  end

  def save
    return false unless valid?
    experience = Experience.create(title: title, category_id: category_id, period_id: period_id, content: content, user_id: user_id)
    unless tags.nil?
      tags.split(',').each do |tag_name|
        tag_name = tag_name.gsub(" ", "")
        tag = Tag.where(name: tag_name).first_or_initialize
        tag.save
        ExperienceTagRelation.create(experience_id: experience.id, tag_id: tag.id)
      end
    end
  end

  def content
    @experience.content
  end

  def set_experience
    @experience = Experience.new(title: title, category_id: category_id, period_id: period_id, content: @content, user_id: user_id)
  end
end