class ExperienceCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_experience, only: [:edit, :update, :destroy]
  before_action :set_experience_comment, only: [:edit, :update, :destroy]

  def create
    comment = ExperienceComment.new(comment_params)
    comment.save
    create_notice(comment)
    redirect_to experience_path(params[:experience_id])
  end

  def edit
    render 'experiences/show'
  end

  def update
    @comment.update(comment_params)
    redirect_to experience_path(params[:experience_id])
  end

  def destroy
    @comment.destroy
    redirect_to experience_path(params[:experience_id])
  end

  private

  def comment_params
    params.require(:experience_comment).permit(:comment).merge(user_id: current_user.id, experience_id: params[:experience_id])
  end

  def set_experience
    @experience = Experience.find(params[:experience_id])
  end

  def set_experience_comment
    @comment = ExperienceComment.find(params[:id])
  end

  def create_notice(comment)
    Notice.create(message:"#{comment.user.nickname} が、あなたの記事「#{comment.experience.title}」に「#{comment.comment}」とコメントしました", url: experience_path(comment.experience.id), user_id: comment.experience.user_id)
  end
end
