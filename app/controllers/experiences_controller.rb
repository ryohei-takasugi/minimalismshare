class ExperiencesController < ApplicationController
  include ExperienceLikeConcern
  include HashModelConcern
  before_action :authenticate_user!,   only: [:new, :create]

  # GET /experiences
  def index
    set_instance_ransack
    set_instance_likes_count
    set_instance_hash_user
    set_instance_hash_exprience
  end

  # GET /experiences/new
  def new
    set_instance_hash_exprience
    @experience_tag = ExperienceTag.new
  end

  # POST /experiences
  def create
    @experience_tag = ExperienceTag.new(set_params_experience_tag)
    if @experience_tag.save
      flash[:notice] = '新しい記事を登録しました'
      redirect_to experiences_path
    else
      render :new
    end
  end

  # GET /experiences/:id
  def show
    set_instance_experience
    set_instance_like
    set_instance_likes_count
    @comment = ExperienceComment.new
  end

  # GET /experiences/:id/edit
  def edit
    set_instance_experience
    set_instance_hash_exprience
    @experience_tag = ExperienceTag.new(set_params_experience_tag_edit)
  end

  # PATCH/PUT /experiences/:id
  def update
    set_instance_experience
    @experience_tag = ExperienceTag.new(set_params_experience_tag)
    @experience_tag.user_id = set_params_experience_tag[:user_id]
    if @experience_tag.update(@experience)
      flash[:notice] = '記事を更新しました'
      redirect_to experience_path(params[:id])
    else
      render :edit
    end
  end

  # DELETE /experiences/:id
  def destroy
    set_instance_experience
    @experience.destroy
    flash[:hazard] = '記事を削除しました'
    redirect_to experiences_path
  end

  # GET /experiences/search_tag(
  def search_tag
    return nil if params[:keyword].blank?

    tags = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tags }
  end

  # GET /experiences/search_index
  def search_index
    set_instance_ransack
    set_instance_likes_count
    set_instance_hash_user
    set_instance_hash_exprience
    render :index
  end

  private

  def set_instance_experience
    @experience = Experience.find(params[:id])
  end

  def set_instance_ransack
    @q = Experience.eager_load(:user).ransack(set_params_search)
    @q.sorts = (set_params_search.nil? ? 'created_at desc' : set_params_search[:sorts])
    @experiences = @q.result.with_rich_text_content
                     .includes(:experience_tag_relations, :tags, :experience_likes)
                     .page(params[:page])
  end

  def set_params_like
    if user_signed_in?
      { experience_id: params[:id], user_id: current_user.id }
    else
      { experience_id: params[:id], user_id: nil }
    end
  end

  def set_params_experience_tag
    params.require(:experience_tag)
          .permit(:title, :tags, :stress, :category_id, :period_id, :content)
          .merge(user_id: current_user.id)
  end

  def set_params_search
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

  def set_params_experience_tag_edit
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
