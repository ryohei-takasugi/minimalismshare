class Tag < ApplicationRecord
  # association DataBase
  has_many :experience_tag_relations
  has_many :experiences, through: :experience_tag_relations
  # validations
  validates :name, uniqueness: true
end
