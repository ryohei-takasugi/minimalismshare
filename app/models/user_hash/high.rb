class High < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '10℃ 以下' },
    { id: 2, name: '15℃' },
    { id: 3, name: '20℃' },
    { id: 4, name: '25℃' },
    { id: 5, name: '30℃' },
    { id: 6, name: '35℃' },
    { id: 7, name: '40℃' },
    { id: 8, name: '45℃' },
    { id: 9, name: '50℃ 以上' }
  ]

  include ActiveHash::Associations
  has_many :users
end
