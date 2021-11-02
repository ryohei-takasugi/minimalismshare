class ExperiencesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_ransack,        only: [:index, :search_article]
  before_action :set_tags,           only: [:index, :search_article]

  def index
    @experiences = Experience.all.includes(:user, :experience_tag_relations, :tags).page(params[:page]).order(updated_at: :desc)
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
    return nil if params[:keyword].blank?
    tags = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tags }
  end
  
  def search_article
    @experiences = @p.result(distinct: true)
                     .includes(:user, :experience_tag_relations, :tags)
                     .page(params[:page])
                     .order(search_params[:sorts])
    render :index
  end

  private

    def experience_tag_params
      params.require(:experience_tag)
            .permit(:title, :tags, :content, :category_id, :period_id, :stress)
            .merge(user_id: current_user.id)
    end

    def set_ransack
      @p = Experience.ransack(search_params)
    end

    def set_tags
      @search_tags = Tag.all
    end

    def search_params
      if params[:q].blank?
        params[:q]
      else
        params.require(:q)
              .permit(:page, :title_cont, :tags_id_eq, :stress_cont, :category_id_eq, :period_id_eq, :sorts)
      end
    end
end
