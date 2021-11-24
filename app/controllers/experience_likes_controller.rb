class ExperienceLikesController < ApplicationController
  include ExperienceLikeConcern
  include NoticeConcern
  before_action :authenticate_user!

  # POST /experiences/:experience_id/experience_likes
  def create
    set_instance_like
    set_instance_experience
    set_instance_comment
    experience_like = ExperienceLike.new(set_params_update_like)
    if experience_like.save
      create_notice(experience_like)
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  # PATCH/PUT /experiences/:experience_id/experience_likes/:id
  def update
    set_instance_like
    set_instance_experience
    set_instance_comment
    experience_like = ExperienceLike.find(params[:id])
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

  def set_instance_experience
    @experience = Experience.find(params[:experience_id])
  end

  def set_instance_comment
    @comment = ExperienceComment.new
  end
end
