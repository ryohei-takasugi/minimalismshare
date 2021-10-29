class ExperiencesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @experiences = Experience.all.order(update_at: :desc).includes(:user)
  end
  
  def new
    @experience = ExperienceTag.new
  end

  def create
    @experience = ExperienceTag.new(experience_params)
    if @experience.save
      redirect_to root_path
    else
      render :new
    end
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end
  
  private

    def experience_params
      params.require(:experience).permit(:title, :tags, :content, :category_id, :period_id).merge(user_id: current_user.id)
    end

end
