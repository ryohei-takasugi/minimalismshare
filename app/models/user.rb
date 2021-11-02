class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # association ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :region
  belongs_to :climate
  belongs_to :housemate
  belongs_to :children
  belongs_to :clean_status
  # association DataBase
  # なし
  # validations
  validates :nickname, presence: true, length: { maximum: 6, message: 'ニックネームは６文字以下です。' }
end
