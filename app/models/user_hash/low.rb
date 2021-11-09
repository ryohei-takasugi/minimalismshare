class Low < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '20℃ 以上' },
    { id: 2, name: '15℃' },
    { id: 3, name: '10℃' },
    { id: 4, name: '5℃' },
    { id: 5, name: '0℃' },
    { id: 6, name: '-10℃' },
    { id: 7, name: '-15℃' },
    { id: 8, name: '-20℃' },
    { id: 9, name: '-25℃ 以下' }
  ]

  include ActiveHash::Associations
  has_many :users
end
