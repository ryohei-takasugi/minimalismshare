class ExperienceCommentsController < ApplicationController
  include ExperienceLikeConcern
  include NoticeParamConcern
  before_action :authenticate_user!
  before_action :set_experience
  before_action :set_comment,          only: [:edit, :update, :destroy]
  before_action :set_like_find_params, only: [:edit, :update, :destroy]
  before_action :set_experience_like,  only: [:edit, :update, :destroy]

  # Call Views: experience/show.html.erb
  def create
    comment = ExperienceComment.new(set_comment_params)
    if comment.save
      create_notice(comment)
      flash[:notice] = 'コメントを追加しました'
      redirect_to experience_path(params[:experience_id])
    else
      @comment = ExperienceComment.new
      render 'experiences/show'
    end
  end

  # Call Views: experience/show.html.erb
  def edit
    render 'experiences/show'
  end

  # Call Views: experience/show.html.erb
  def update
    if @comment.update(set_comment_params)
      flash[:notice] = 'コメントを更新しました'
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  # Call Views: experience/show.html.erb
  def destroy
    if @comment.destroy
      flash[:hazard] = 'コメントを削除しました'
      redirect_to experience_path(params[:experience_id])
    else
      render 'experiences/show'
    end
  end

  private

  def set_comment_params
    params.require(:experience_comment).permit(:comment).merge(user_id: current_user.id, experience_id: params[:experience_id])
  end

  def set_experience
    @experience = Experience.find(params[:experience_id])
  end

  def set_comment
    @comment = ExperienceComment.find(params[:id])
  end

  def set_like_find_params
    { experience_id: params[:experience_id], user_id: current_user.id }
  end

  def create_notice(comment)
    notice = Notice.new(set_notice_params(comment, comment.comment))
    notice.save
  end
end
