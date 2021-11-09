class Notice < ApplicationRecord
  # association DataBase
  belongs_to :user
  # validations
  validates :message, presence: true
  validates :url,     presence: true
end
