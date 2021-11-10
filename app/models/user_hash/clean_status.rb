class CleanStatus < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'すでにかなり物が少ない' },
    { id: 2, name: 'ある程度物を減らして片付いている' },
    { id: 3, name: 'ちょっとだけ減らした' },
    { id: 4, name: 'まだ何もしてない' }
  ]

  include ActiveHash::Associations
  has_many :users
end
