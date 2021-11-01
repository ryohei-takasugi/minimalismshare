class ExperiencesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @experiences = Experience.all.order(updated_at: :desc).includes(:user, :experience_tag_relations, :tags)
  end
  
  def new
    @experience_tag = ExperienceTag.new
  end

  def create
    @experience_tag = ExperienceTag.new(experience_tag_params)
    if @experience_tag.save
      redirect_to root_path
    else
      render :new
    end
  end

  def search_tag
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end
  
  def search_article
  end

  private

    def experience_tag_params
      params.require(:experience_tag).permit(:title, :tags, :content, :category_id, :period_id, :stress).merge(user_id: current_user.id)
    end
end
