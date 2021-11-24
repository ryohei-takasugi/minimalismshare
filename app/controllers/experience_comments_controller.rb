class ExperienceCommentsController < ApplicationController
  include ExperienceLikeConcern
  include NoticeConcern
  before_action :authenticate_user!

  # POST /experiences/:experience_id/experience_comments
  def create
    set_instance_experience
    comment = ExperienceComment.new(set_params_comment)
    if comment.save
      create_notice(comment)
      flash[:notice] = 'コメントを追加しました'
      redirect_to experience_path(params[:experience_id])
    else
      @comment = ExperienceComment.new
      render 'experiences/show'
    end
  end

  # GET /experiences/:experience_id/experience_comments/:id/edit
  def edit
    set_instance_experience
    set_instance_comment
    set_instance_like
    render 'experiences/show'
  end

  # PATCH/PUT /experiences/:experience_id/experience_comments/:id
  def update
    set_instance_experience
    set_instance_comment
    set_instance_like
    if @comment.update(set_params_comment)
      flash[:notice] = 'コメントを更新しました'
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  # DELETE /experiences/:experience_id/experience_comments/:id
  def destroy
    set_instance_experience
    set_instance_comment
    set_instance_like
    if @comment.destroy
      flash[:hazard] = 'コメントを削除しました'
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  private

  def set_params_comment
    params.require(:experience_comment).permit(:comment).merge(user_id: current_user.id, experience_id: params[:experience_id])
  end

  def set_params_like
    { experience_id: params[:experience_id], user_id: current_user.id }
  end

  def set_instance_experience
    @experience = Experience.find(params[:experience_id])
  end

  def set_instance_comment
    @comment = ExperienceComment.find(params[:id])
  end
end
