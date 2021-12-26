class ExperienceLikesController < ApplicationController
  include ExperienceConcern
  include NoticeConcern
  before_action :authenticate_user!
  before_action :confirm_identification

  # POST /experiences/:experience_id/experience_likes
  def create
    experience_like = ExperienceLike.new(set_params_update_like)
    if experience_like.save
      create_notice(experience_like)
      redirect_to experience_path(params[:experience_id])
    else
      set_view_instance_show(params[:experience_id], set_params_like)
      render 'experiences/show'
    end
  end

  # PATCH/PUT /experiences/:experience_id/experience_likes/:id
  def update
    experience_like = ExperienceLike.find(params[:id])
    if experience_like.update(set_params_update_like)
      create_notice(experience_like)
      redirect_to experience_path(params[:experience_id])
    else
      set_view_instance_show(params[:experience_id], set_params_like)
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

  def confirm_identification
    experience = Experience.find(params[:experience_id])
    redirect_to experiences_path if experience.user_id == current_user.id
  end
end
