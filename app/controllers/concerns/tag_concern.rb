require 'active_support'

module TagConcern
  extend ActiveSupport::Concern

  def set_instance_search_tags(keyword)
    Tag.where(['name LIKE ?', "%#{keyword}%"])
  end
end