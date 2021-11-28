require 'active_support'

module UserConcern
  extend ActiveSupport::Concern

  def set_user_find(id)
    User.find(id)
  end
end
