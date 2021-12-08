class ExperienceLike < ApplicationRecord
  # association DataBase
  belongs_to :user
  belongs_to :experience
  # scope
  scope :count_likes, -> { where(like: true).group('experience_likes.experience_id').count }
  scope :count_imitates, -> { where(imitate: true).group('experience_likes.experience_id').count }
end
