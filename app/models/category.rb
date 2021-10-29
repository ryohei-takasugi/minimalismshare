class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '成功' },
    { id: 2, name: '失敗' }
  ]

  include ActiveHash::Associations
  has_many :experiences
end
