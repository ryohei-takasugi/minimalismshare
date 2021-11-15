class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_identification
  before_action :set_likes_count

  # Call Views: users/show.html.erb
  def show
    @user = User.find(params[:id])
    user_notice = Notice.where(user_id: current_user.id)
    user_notice.update(read: true)
    @all_notices = Notice.where(user_id: current_user.id)
                         .limit(100)
                         .order(updated_at: :desc)
                         .page(params[:page])
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
