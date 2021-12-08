class ExperienceCommentsController < ApplicationController
  include ExperienceConcern
  include NoticeConcern
  before_action :authenticate_user!

  # POST /experiences/:experience_id/experience_comments
  def create
    comment = ExperienceComment.new(set_params_comment)
    if comment.save
      create_notice(comment)
      flash[:notice] = 'コメントを追加しました'
      redirect_to experience_path(params[:experience_id])
    else
      set_view_instance_show(params[:experience_id], set_params_like)
      render 'experiences/show'
    end
  end

  # GET /experiences/:experience_id/experience_comments/:id/edit
  def edit
    set_view_instance_show(params[:experience_id], set_params_like)
    @comment = ExperienceComment.find(params[:id])
    render 'experiences/show'
  end

  # PATCH/PUT /experiences/:experience_id/experience_comments/:id
  def update
    @comment = ExperienceComment.find(params[:id])
    if @comment.update(set_params_comment)
      flash[:notice] = 'コメントを更新しました'
      redirect_to experience_path(params[:experience_id])
    else
      set_view_instance_show(params[:experience_id], set_params_like)
      render 'experiences/show'
    end
  end

  # DELETE /experiences/:experience_id/experience_comments/:id
  def destroy
    @comment = ExperienceComment.find(params[:id])
    if @comment.destroy
      flash[:hazard] = 'コメントを削除しました'
      redirect_to experience_path(params[:experience_id])
    else
      set_view_instance_show(params[:experience_id], set_params_like)
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
