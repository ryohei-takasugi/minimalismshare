require 'active_support'

module ExperienceConcern
  extend ActiveSupport::Concern

  def set_view_instance_index(params_experience, params_search)
    @q = set_ransack_query(params_search)
    @experiences    = set_ransack_experiences(@q, params_experience[:page])
    @user_hash      = set_hash_user
    @exprience_hash = set_hash_exprience
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    @likes_count    = ExperienceLike.count_likes
    @imitates_count = ExperienceLike.count_imitates
  end

  def set_view_instance_show(experience_id, params_like)
    @like           = find_by_like(params_like) if user_signed_in?
    @experience     = Experience.find(experience_id)
    @comment        = ExperienceComment.new
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    @likes_count    = ExperienceLike.count_likes
    @imitates_count = ExperienceLike.count_imitates
  end

  def set_view_instance_form(params_experience = nil)
    @exprience_hash = set_hash_exprience
    @experience_tag = ExperienceTag.new(params_experience)
  end

  private

  def find_by_like(params)
    like = ExperienceLike.find_by(params)
    like ||= ExperienceLike.new
  end
end
