class Experience < ApplicationRecord
  # association ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :period
  belongs_to :category
  # association DataBase
  belongs_to :user
  has_many :experience_tag_relations
  has_many :tags, through: :experience_tag_relations
  has_rich_text :content
  has_one :content, class_name: 'ActionText::RichText', as: :record
  # validation
end
