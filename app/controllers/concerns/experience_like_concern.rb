require 'active_support'

module ExperienceLikeConcern
  extend ActiveSupport::Concern

  def set_experience_like
    if user_signed_in?
      @like = ExperienceLike.find_by(set_like_find_params)
      @like ||= ExperienceLike.new
    end
  end

  def set_likes_count
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    @like_group_list = ExperienceLike.where(like: true).group('experience_likes.experience_id').count
    @imitate_group_list = ExperienceLike.where(imitate: true).group('experience_likes.experience_id').count
  end
end