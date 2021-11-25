require 'active_support'

module RansackConcern
  extend ActiveSupport::Concern

  def set_instance_ransack(params_search)
    q = Experience.eager_load(:user).ransack(params_search)
    q.sorts = (params_search.nil? ? default_sorts : params_search[:sorts])
    q
  end

  def set_instance_ransack_experiences(query, page)
    experiences = query.result
                       .includes(:experience_tag_relations, :tags, :experience_likes)
                       .page(page)
  end

  private

  def default_sorts
    ['created_at desc']
  end
end