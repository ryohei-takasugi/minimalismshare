class ExperienceLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    experience_like = ExperienceLike.new(like_params)
    if experience_like.save
      create_notice(experience_like)
      redirect_to experience_path(params[:experience_id])
    else
      @experience = Experience.find(params[:experience_id])
      @comment = ExperienceComment.new
      @like = ExperienceLike.new
      render 'experiences/show'
    end
  end

  def update
    experience_like = ExperienceLike.find(params[:id])
    if experience_like.update(like_params)
      create_notice(experience_like)
      redirect_to experience_path(params[:experience_id])
    else
      @experience = Experience.find(params[:experience_id])
      @comment = ExperienceComment.new
      @like = ExperienceLike.find_by(params[:id])
      @like = ExperienceLike.new if @like.blank?
      render 'experiences/show'
    end
  end

  private

  def create_notice(experience_like)
    unless set_action.nil?
      Notice.create(message:"#{experience_like.user.nickname} が、あなたの記事「#{experience_like.experience.title}」に「#{set_action}」しました", url: experience_path(experience_like.experience.id), user_id: experience_like.experience.user_id)
    end
  end

  def set_action
    if like_params.include?(:like) && like_params[:like].match(/(true|True|TRUE)/)
      action = 'いいね'
    elsif like_params.include?(:imitate) && like_params[:imitate].match(/(true|True|TRUE)/)
      action = '真似した'
    else
      nil
    end
  end

  def like_params
    params.require(:experiences_like).permit(:like, :imitate).merge(experience_id: params[:experience_id],
                                                                    user_id: current_user.id)
  end
end
