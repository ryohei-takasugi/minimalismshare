class Notice < ApplicationRecord
  # association DataBase
  belongs_to :user
  # validations
  validates :message, presence: true
  validates :url,     presence: true
  # scope
  scope :recent, -> (user_id) { where(user_id: user_id).order(id: :desc).limit(10) }
  scope :recent_100, -> (user_id) { where(user_id: user_id).order(id: :desc).limit(100) }
end
