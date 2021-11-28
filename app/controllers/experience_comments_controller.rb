class ExperienceCommentsController < ApplicationController
  include ExperienceConcern
  include ExperienceLikeConcern
  include ExperienceCommentConcern
  include NoticeConcern
  before_action :authenticate_user!

  # POST /experiences/:experience_id/experience_comments
  def create
    @experience = find_experience(params[:experience_id])
    comment     = new_comment(set_params_comment)
    if comment.save
      create_notice(comment)
      flash[:notice] = 'コメントを追加しました'
      redirect_to experience_path(params[:experience_id])
    else
      @comment = new_comment
      render 'experiences/show'
    end
  end

  # GET /experiences/:experience_id/experience_comments/:id/edit
  def edit
    @like       = find_by_like(set_params_like) if user_signed_in?
    @experience = find_experience(params[:experience_id])
    @comment    = find_comment(params[:id])
    render 'experiences/show'
  end

  # PATCH/PUT /experiences/:experience_id/experience_comments/:id
  def update
    @like       = find_by_like(set_params_like) if user_signed_in?
    @experience = find_experience(params[:experience_id])
    @comment    = find_comment(params[:id])
    if @comment.update(set_params_comment)
      flash[:notice] = 'コメントを更新しました'
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  # DELETE /experiences/:experience_id/experience_comments/:id
  def destroy
    @like       = find_by_like(set_params_like) if user_signed_in?
    @experience = find_experience(params[:experience_id])
    @comment    = find_comment(params[:id])
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
end
