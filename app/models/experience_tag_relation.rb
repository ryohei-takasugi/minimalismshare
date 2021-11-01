class ExperienceTagRelation < ApplicationRecord
  belongs_to :tag
  belongs_to :experience
end
