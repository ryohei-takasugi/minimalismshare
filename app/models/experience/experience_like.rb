class ExperienceLike < ApplicationRecord
  # association DataBase
  belongs_to :user
  belongs_to :experience
end
