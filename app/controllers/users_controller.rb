class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likes_count

  # Call Views: users/show.html.erb
  def show
    @user = User.find(params[:id])
    Notice.update(read: true)
    @all_notices = Notice.where(user_id: current_user.id)
                         .limit(100)
                         .order(updated_at: :desc)
                         .page(params[:page])
    @experiences = Experience.where(user_id: current_user.id)
                             .order(updated_at: :desc)
                             .page(params[:page])
    @experience_likes = ExperienceLike.where(user_id: current_user.id)
                                      .order(updated_at: :desc)
                                      .page(params[:page])
=begin
    @experiences = Experience.where(user_id: current_user.id)
                             .preload(:experience_tag_relations, :tags, :experience_likes)
                             .eager_load(:user)
                             .order(updated_at: :desc)
                             .page(params[:page])
    @experience_likes = ExperienceLike.where(user_id: current_user.id)
                                      .eager_load(:experience, :user)
                                      .order(updated_at: :desc)
                                      .page(params[:page]) 
=end
  end
end
