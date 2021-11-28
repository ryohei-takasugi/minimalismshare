require 'active_support'

module ExperienceCommentConcern
  extend ActiveSupport::Concern

  def new_comment(params = nil)
    ExperienceComment.new(params)
  end

  def find_comment(id)
    ExperienceComment.find(id)
  end
end
