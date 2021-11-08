class Housemate < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '１人' },
    { id: 2, name: '２人' },
    { id: 3, name: '家族' }
  ]

  include ActiveHash::Associations
  has_many :users
end
