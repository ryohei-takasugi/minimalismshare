class ExperienceTagRelation < ApplicationRecord
  # association DataBase
  belongs_to :tag
  belongs_to :experience
end
