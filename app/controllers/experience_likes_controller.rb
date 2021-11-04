class ExperienceLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    experience_like = ExperienceLike.new(like_params)
    if experience_like.save
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

  def like_params
    params.require(:experiences_like).permit(:like, :imitate).merge(experience_id: params[:experience_id], user_id: current_user.id)
  end
end
