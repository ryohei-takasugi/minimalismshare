require 'active_support'

module ExperienceCommentConcern
  extend ActiveSupport::Concern

  def set_instance_comment_new(params = nil)
    if params.nil?
      ExperienceComment.new
    else
      ExperienceComment.new(params)
    end
  end

  def set_instance_comment_find(id)
    ExperienceComment.find(id)
  end
end