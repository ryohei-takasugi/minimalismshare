class Children < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '無' },
    { id: 2, name: '有' },
  ]

  include ActiveHash::Associations
  has_many :users
end