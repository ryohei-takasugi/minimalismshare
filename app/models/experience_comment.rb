class ExperienceComment < ApplicationRecord
  # association DataBase
  belongs_to :user
  belongs_to :experience
  # validation
  validates :comment, presence: true
end
