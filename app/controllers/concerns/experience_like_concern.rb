require 'active_support'

module ExperienceLikeConcern
  extend ActiveSupport::Concern

  def set_instance_like
    if user_signed_in?
      @like = ExperienceLike.find_by(set_params_like)
      @like ||= ExperienceLike.new
    end
  end

  def set_instance_likes_count
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    @like_group_list = ExperienceLike.count_likes
    @imitate_group_list = ExperienceLike.count_imitates
  end
end