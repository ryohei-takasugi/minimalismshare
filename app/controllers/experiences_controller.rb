class ExperiencesController < ApplicationController
  include ExperienceConcern
  include ExperienceTagConcern
  include ExperienceLikeConcern
  include ExperienceCommentConcern
  include HashModelConcern
  include RansackConcern
  before_action :authenticate_user!, only: [:new, :create]

  # GET /experiences
  def index
    @q = set_instance_ransack(set_params_search)
    @experiences = set_instance_ransack_experiences(@q, params[:page])
    @user_hash = set_instance_hash_user
    @exprience_hash = set_instance_hash_exprience
    @like_group_list = set_instance_likes_count
    @imitate_group_list = set_instance_imitates_count
  end

  # GET /experiences/new
  def new
    @exprience_hash = set_instance_hash_exprience
    @experience_tag = set_instance_exptag_new
  end

  # POST /experiences
  def create
    @experience_tag = set_instance_exptag_new(set_params_experience_tag)
    if @experience_tag.save
      flash[:notice] = '新しい記事を登録しました'
      redirect_to experiences_path
    else
      render :new
    end
  end

  # GET /experiences/:id
  def show
    @experience = set_instance_experience_find(params[:id])
    @like = set_instance_like if user_signed_in?
    @like_group_list = set_instance_likes_count
    @imitate_group_list = set_instance_imitates_count
    @comment = set_instance_comment_new()
  end

  # GET /experiences/:id/edit
  def edit
    @experience = set_instance_experience_find(params[:id])
    @exprience_hash = set_instance_hash_exprience
    @experience_tag = set_instance_exptag_new(set_params_experience_tag_edit(@experience))
  end

  # PATCH/PUT /experiences/:id
  def update
    @experience = set_instance_experience_find(params[:id])
    @experience_tag = set_instance_exptag_new(set_params_experience_tag)
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
    @experience = set_instance_experience_find(params[:id])
    @experience.destroy
    flash[:hazard] = '記事を削除しました'
    redirect_to experiences_path
  end

  # GET /experiences/search_tag(
  def search_tag
    return nil if params[:keyword].blank?

    tags = set_instance_search_tags(params[:keyword])
    render json: { keyword: tags }
  end

  # GET /experiences/search_index
  def search_index
    @q = set_instance_ransack(set_params_search)
    @experiences = set_instance_ransack_experiences(@q, params[:page])
    @user_hash = set_instance_hash_user
    @exprience_hash = set_instance_hash_exprience
    @like_group_list = set_instance_likes_count
    @imitate_group_list = set_instance_imitates_count
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
end
