class ExperiencesController < ApplicationController
  include ExperienceLikeConcern
  include HashModelConcern
  before_action :authenticate_user!,   only: [:new, :create]
  before_action :set_ransack,          only: [:index, :search_index]
  before_action :set_experience,       only: [:show, :edit, :update, :destroy]
  before_action :set_like_find_params, only: [:show]
  before_action :set_experience_like,  only: [:show]
  before_action :set_likes_count,      only: [:index, :show, :search_index]
  before_action :set_user_hash,        only: [:index, :search_index]
  before_action :set_exprience_hash,   only: [:index, :new, :edit, :search_index]

  # Call Views: experience/index.html.erb
  def index
  end

  # Call Views: experience/new.html.erb
  def new
    @experience_tag = ExperienceTag.new
  end

  # Call Views: experience/new.html.erb
  def create
    @experience_tag = ExperienceTag.new(set_experience_tag_params)
    if @experience_tag.save
      flash[:notice] = '新しい記事を登録しました'
      redirect_to experiences_path
    else
      render :new
    end
  end

  # Call Views: experience/show.html.erb
  def show
    @comment = ExperienceComment.new
  end

  # Call Views: experience/edit.html.erb
  def edit
    @experience_tag = ExperienceTag.new(set_edit_experience_tag_params)
  end

  # Call Views: experience/edit.html.erb
  def update
    @experience_tag = ExperienceTag.new(set_experience_tag_params)
    @experience_tag.user_id = set_experience_tag_params[:user_id]
    if @experience_tag.update(@experience)
      flash[:notice] = '記事を更新しました'
      redirect_to experience_path(params[:id])
    else
      render :edit
    end
  end

  # Call Views: experience/show.html.erb
  def destroy
    @experience.destroy
    flash[:hazard] = '記事を削除しました'
    redirect_to experiences_path
  end

  # Call Views: experience/new.html.erb
  def search_tag
    return nil if params[:keyword].blank?

    tags = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tags }
  end

  # Call Views: experience/index.html.erb
  def search_index
    render :index
  end

  private

  def set_experience
    @experience = Experience.find(params[:id])
  end

  def set_ransack
    @q = Experience.eager_load(:user).ransack(set_search_params)
    @q.sorts = (set_search_params.nil? ? 'created_at desc' : set_search_params[:sorts])
    @experiences = @q.result.with_rich_text_content
                     .includes(:experience_tag_relations, :tags, :experience_likes)
                     .page(params[:page])
  end

  def set_like_find_params
    if user_signed_in?
      { experience_id: params[:id], user_id: current_user.id }
    else
      { experience_id: params[:id], user_id: nil }
    end
  end

  def set_experience_tag_params
    params.require(:experience_tag)
          .permit(:title, :tags, :stress, :category_id, :period_id, :content)
          .merge(user_id: current_user.id)
  end

  def set_search_params
    if params[:q].blank?
      params[:q]
    else
      params.require(:q)
            .permit(:title_or_stress_or_content_body_cont, 
                    :tags_id_eq, 
                    :category_id_eq, 
                    :period_id_eq, 
                    :user_high_id_eq, 
                    :user_low_id_eq, 
                    :user_housemate_id_eq, 
                    :user_hobby_id_eq, 
                    :user_clean_status_id_eq, 
                    :user_range_with_store_id_eq, 
                    :sorts)
    end
  end

  def set_edit_experience_tag_params()
    {
      title: @experience.title,
      tags: @experience.tags.map { |tag| tag.name },
      stress: @experience.stress,
      category_id: @experience.category_id,
      period_id: @experience.period_id,
      content: @experience.content
    }
  end
end
