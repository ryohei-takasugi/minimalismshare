class Hobby < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'どちらかといえば無趣味／無関心事' },
    { id: 2, name: '１つの集中する趣味／関心事がある' },
    { id: 3, name: '多趣味／関心事の変化が多い' }
  ]

  include ActiveHash::Associations
  has_many :users
end
