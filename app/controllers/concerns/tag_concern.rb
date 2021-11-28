require 'active_support'

module TagConcern
  extend ActiveSupport::Concern

  def search_tags(keyword)
    Tag.tags_serch(keyword)
  end
end
