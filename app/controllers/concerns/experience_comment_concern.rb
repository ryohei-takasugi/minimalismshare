require 'active_support'

module ExperienceCommentConcern
  extend ActiveSupport::Concern

  def set_comment_new(params = nil)
    ExperienceComment.new(params)
  end

  def set_comment_find(id)
    ExperienceComment.find(id)
  end
end
