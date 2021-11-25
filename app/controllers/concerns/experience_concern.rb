require 'active_support'

module ExperienceConcern
  extend ActiveSupport::Concern

  def set_instance_experience_find(id)
    Experience.find(id)
  end
end