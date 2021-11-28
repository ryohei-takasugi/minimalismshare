require 'active_support'

module ExperienceLikeConcern
  extend ActiveSupport::Concern

  def set_like_new(params = nil)
    ExperienceLike.new(params)
  end

  def set_like_find(id)
    ExperienceLike.find(id)
  end

  def set_like_find_by(params)
    like = ExperienceLike.find_by(params)
    like ||= ExperienceLike.new
  end

  def set_likes_count
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    ExperienceLike.count_likes
  end

  def set_imitates_count
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    ExperienceLike.count_imitates
  end
end
