require 'active_support'

module ExperienceLikeConcern
  extend ActiveSupport::Concern

  def set_instance_like_new(params = nil)
    if params.nil?
      ExperienceLike.new
    else
      ExperienceLike.new(params)
    end
  end

  def set_instance_like_find(id)
    ExperienceLike.find(id)
  end
  
  def set_instance_like
    like = ExperienceLike.find_by(set_params_like)
    like ||= ExperienceLike.new
  end

  def set_instance_likes_count
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    ExperienceLike.count_likes
  end

  def set_instance_imitates_count
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    ExperienceLike.count_imitates
  end
end