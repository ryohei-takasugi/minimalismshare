require 'active_support'

module ExperienceTagConcern
  extend ActiveSupport::Concern

  def set_experience_tag_new(params = nil)
    ExperienceTag.new(params)
  end
end
