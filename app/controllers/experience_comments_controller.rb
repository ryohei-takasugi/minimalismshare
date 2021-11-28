class ExperienceCommentsController < ApplicationController
  include ExperienceConcern
  include ExperienceLikeConcern
  include ExperienceCommentConcern
  include NoticeConcern
  before_action :authenticate_user!

  # POST /experiences/:experience_id/experience_comments
  def create
    @experience = set_experience_find(params[:experience_id])
    comment     = set_comment_new(set_params_comment)
    if comment.save
      create_notice(comment)
      flash[:notice] = 'コメントを追加しました'
      redirect_to experience_path(params[:experience_id])
    else
      @comment = set_comment_new
      render 'experiences/show'
    end
  end

  # GET /experiences/:experience_id/experience_comments/:id/edit
  def edit
    @like       = set_like_find_by(set_params_like) if user_signed_in?
    @experience = set_experience_find(params[:experience_id])
    @comment    = set_comment_find(params[:id])
    render 'experiences/show'
  end

  # PATCH/PUT /experiences/:experience_id/experience_comments/:id
  def update
    @like       = set_like_find_by(set_params_like) if user_signed_in?
    @experience = set_experience_find(params[:experience_id])
    @comment    = set_comment_find(params[:id])
    if @comment.update(set_params_comment)
      flash[:notice] = 'コメントを更新しました'
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  # DELETE /experiences/:experience_id/experience_comments/:id
  def destroy
    @like       = set_like_find_by(set_params_like) if user_signed_in?
    @experience = set_experience_find(params[:experience_id])
    @comment    = set_comment_find(params[:id])
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
