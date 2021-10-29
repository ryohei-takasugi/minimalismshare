class Tag < ApplicationRecord
  has_many :experience_tag_relations
  has_many :experiences, through: :experience_tag_relations
  validates :name, uniqueness: true
end
