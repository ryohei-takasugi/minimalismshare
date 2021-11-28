require 'active_support'

module ExperienceLikeConcern
  extend ActiveSupport::Concern

  def new_like(params = nil)
    ExperienceLike.new(params)
  end

  def find_like(id)
    ExperienceLike.find(id)
  end

  def find_by_like(params)
    like = ExperienceLike.find_by(params)
    like ||= ExperienceLike.new
  end

  def count_likes
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    ExperienceLike.count_likes
  end

  def count_imitates
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    ExperienceLike.count_imitates
  end
end
