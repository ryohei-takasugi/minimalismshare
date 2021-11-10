class ExperienceComment < ApplicationRecord
  # association DataBase
  belongs_to :user
  belongs_to :experience, optional: true
  # validation
  validates :comment, presence: true
end
