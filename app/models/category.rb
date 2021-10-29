class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '成功体験' },
    { id: 2, name: '失敗体験' },
    { id: 3, name: 'やってみた' }
  ]

  include ActiveHash::Associations
  has_many :experiences
end
