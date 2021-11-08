class Climate < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '日本では比較的寒い地域' },
    { id: 2, name: '日本では比較的温かい地域' },
    { id: 3, name: '日本では寒暖差の少ない地域' }
  ]

  include ActiveHash::Associations
  has_many :users
end
