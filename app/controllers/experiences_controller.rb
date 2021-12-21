class ExperiencesController < ApplicationController
  include ExperienceConcern
  include HashModelConcern
  include RansackConcern
  before_action :authenticate_user!, only: [:new, :create]
  before_action :confirm_identification, only: [:edit, :update, :destroy]

  # GET /experiences
  def index
    set_view_instance_index(params, set_params_search)
  end

  # GET /experiences/new
  def new
    set_view_instance_form
  end

  # POST /experiences
  def create
    set_view_instance_form
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
    set_view_instance_show(params[:id], set_params_like)
  end

  # GET /experiences/:id/edit
  def edit
    @experience = Experience.find(params[:id])
    set_view_instance_form(set_params_experience_tag_edit(@experience))
  end

  # PATCH/PUT /experiences/:id
  def update
    @experience     = Experience.find(params[:id])
    @experience_tag = ExperienceTag.new(set_params_experience_tag)
    @experience_tag.user_id = set_params_experience_tag[:user_id]
    if @experience_tag.update(@experience)
      flash[:notice] = '記事を更新しました'
      redirect_to experience_path(params[:id])
    else
      @exprience_hash = set_hash_exprience
      render :edit
    end
  end

  # DELETE /experiences/:id
  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    flash[:hazard] = '記事を削除しました'
    redirect_to experiences_path
  end

  # GET /experiences/search_tag
  def search_tag
    return nil if params[:keyword].blank?

    tags = Tag.tags_serch(params[:keyword])
    render json: { keyword: tags }
  end

  # GET /experiences/search_index
  def search_index
    set_view_instance_index(params, set_params_search)
    render :index
  end

  private

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

  def set_params_experience_tag_edit(experience)
    {
      title: experience.title,
      tags: experience.tags.map { |tag| tag.name },
      stress: experience.stress,
      category_id: experience.category_id,
      period_id: experience.period_id,
      content: experience.content
    }
  end

  def confirm_identification
    experience = Experience.find(params[:id])
    redirect_to experiences_path unless experience.user_id == current_user.id
  end
end
