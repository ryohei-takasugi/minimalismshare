require 'active_support'

module ExperienceTagConcern
  extend ActiveSupport::Concern

  def set_instance_exptag_new(params = nil)
    if params.nil?
      ExperienceTag.new
    else
      ExperienceTag.new(params)
    end
  end
end