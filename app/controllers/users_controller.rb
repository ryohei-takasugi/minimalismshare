class UsersController < ApplicationController
  include ExperienceLikeConcern
  include NoticeConcern
  include UserConcern
  before_action :authenticate_user!
  before_action :confirm_identification

  # GET /users/:id
  def show
    @likes_count    = set_likes_count
    @imitates_count = set_imitates_count
    @user           = set_user_find(params[:id])
    @all_notices    = set_notice_100(current_user.id, params[:page])
    read_notice(current_user.id)
    # <%# FIXME: タブ切り替え後にページ切り替えをするとタブが初期値に戻るためコメントアウト >
    # @experiences = Experience.where(user_id: current_user.id)
    #                          .includes(:experience_tag_relations, :tags, :experience_likes)
    #                          .order(updated_at: :desc)
    #                          .page(params[:page])
    #                          .with_rich_text_content
    # @experience_likes = ExperienceLike.where(user_id: current_user.id)
    #                                   .order(updated_at: :desc)
    #                                   .page(params[:page])
  end

  private

  def confirm_identification
    redirect_to user_path(current_user) unless params[:id].to_i == current_user.id
  end
end
