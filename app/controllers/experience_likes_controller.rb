class ExperienceLikesController < ApplicationController
  include ExperienceConcern
  include ExperienceLikeConcern
  include ExperienceCommentConcern
  include NoticeConcern
  before_action :authenticate_user!

  # POST /experiences/:experience_id/experience_likes
  def create
    @like       = find_by_like(set_params_like) if user_signed_in?
    @experience = find_experience(params[:experience_id])
    @comment    = new_comment
    experience_like = new_like(set_params_update_like)
    if experience_like.save
      create_notice(experience_like)
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  # PATCH/PUT /experiences/:experience_id/experience_likes/:id
  def update
    @like       = find_by_like(set_params_like) if user_signed_in?
    @experience = find_experience(params[:experience_id])
    @comment    = new_comment
    experience_like = find_like(params[:id])
    if experience_like.update(set_params_update_like)
      create_notice(experience_like)
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  private

  def set_params_update_like
    params.require(:experiences_like)
          .permit(:like, :imitate)
          .merge(experience_id: params[:experience_id], user_id: current_user.id)
  end

  def set_params_like
    { experience_id: params[:experience_id], user_id: current_user.id }
  end
end
