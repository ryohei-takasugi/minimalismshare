class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configre_permitted_paramter, if: :devise_controller?
  before_action :set_notice

  private

  def configre_permitted_paramter
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :dream, :high_id, :low_id, :housemate_id, :hobby_id, :clean_status_id, :range_with_store_id])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def set_notice
    if user_signed_in?
      @notices = Notice.where(user_id: current_user.id).limit(10).order(created_at: :desc)
    end
  end

  # used
  #   ExperienceCommentsController
  #   ExperienceLikesController
  #   ExperiencesController
  def set_experience_like
    if user_signed_in?
      @like = ExperienceLike.find_by(set_like_find_params)
      @like = ExperienceLike.new if @like.blank?
    end
  end

  # used
  #    ExperiencesController
  #    UsersController
  def set_likes_count
    # OPTIMIZE: ①テーブルの変更 : like とimitate を category カラムに統一して、groupで絞り込むことで1回のアクセスになるはず
    @like_group_list = ExperienceLike.where(like: true).group("experience_likes.experience_id").count
    @imitate_group_list = ExperienceLike.where(imitate: true).group("experience_likes.experience_id").count
  end
end
