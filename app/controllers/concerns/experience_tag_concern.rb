require 'active_support'

module ExperienceTagConcern
  extend ActiveSupport::Concern

  def new_experience_tag(params = nil)
    ExperienceTag.new(params)
  end
end
