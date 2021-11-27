require 'active_support'

module RansackConcern
  extend ActiveSupport::Concern

  def set_ransack_query(params)
    q = Experience.eager_load(:user).ransack(params)
    q.sorts = (params.nil? ? default_sorts : params[:sorts])
    q
  end

  def set_ransack_experiences(query, page)
    experiences = query.result
                       .includes(:experience_tag_relations, :tags, :experience_likes)
                       .page(page)
  end

  private

  def default_sorts
    ['created_at desc']
  end
end