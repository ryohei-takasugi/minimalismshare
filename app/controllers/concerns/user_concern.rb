require 'active_support'

module UserConcern
  extend ActiveSupport::Concern

  def find_user(id)
    User.find(id)
  end
end
