require 'active_support'

module ExperienceConcern
  extend ActiveSupport::Concern

  def find_experience(id)
    Experience.find(id)
  end
end
