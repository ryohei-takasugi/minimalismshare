class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # association ActiveHash
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :high
  belongs_to :low
  belongs_to :housemate
  belongs_to :hobby
  belongs_to :clean_status
  belongs_to :range_with_store
  # association DataBase
  has_many :experiences
  has_many :experience_likes
  has_many :experience_comments
  has_many :notices
  # validations
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, presence: true, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }
  validates :nickname, presence: true, length: { maximum: 6, message: 'ニックネームは６文字以下です。' }
end
