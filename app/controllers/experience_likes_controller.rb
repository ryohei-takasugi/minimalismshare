class ExperienceLikesController < ApplicationController
  include ExperienceConcern
  include ExperienceLikeConcern
  include ExperienceCommentConcern
  include NoticeConcern
  before_action :authenticate_user!

  # POST /experiences/:experience_id/experience_likes
  def create
    @like = set_instance_like if user_signed_in?
    @experience = set_instance_experience_find(params[:experience_id])
    @comment = set_instance_comment_new
    experience_like = set_instance_like_new(set_params_update_like)
    if experience_like.save
      create_notice(experience_like)
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  # PATCH/PUT /experiences/:experience_id/experience_likes/:id
  def update
    @like = set_instance_like if user_signed_in?
    @experience = set_instance_experience_find(params[:experience_id])
    @comment = set_instance_comment_new
    experience_like = set_instance_like_find(params[:id])
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
