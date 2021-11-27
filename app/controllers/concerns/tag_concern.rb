require 'active_support'

module TagConcern
  extend ActiveSupport::Concern

  def set_tags_search(keyword)
    Tag.tags_serch(keyword)
  end
end