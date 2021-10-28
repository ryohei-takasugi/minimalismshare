class Climate < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '比較的寒い地域' },
    { id: 2, name: '比較的温かい地域' },
    { id: 3, name: '寒暖差の少ない地域' },
  ]

  include ActiveHash::Associations
  has_many :users
end
