class Tag < ApplicationRecord
  # association DataBase
  has_many :experience_tag_relations
  has_many :experiences, through: :experience_tag_relations
  # validations
  validates :name, uniqueness: { case_sensitive: false } # DEPRECATION WARNING: Uniqueness validator will no longer enforce case sensitive comparison in Rails 6.1.
  # scope
  scope :tags_serch, -> (keyword) { where(['name LIKE ?', "%#{keyword}%"]) }
end
