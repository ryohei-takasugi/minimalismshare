require 'active_support'

module ExperienceLikeConcern
  extend ActiveSupport::Concern

  def set_experience_like
    if user_signed_in?
      @like = ExperienceLike.find_by(set_like_find_params)
      @like ||= ExperienceLike.new
    end
  end
end