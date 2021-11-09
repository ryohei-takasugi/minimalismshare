class RangeWithStore < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'お店どころか運送業者も来れない' },
    { id: 2, name: 'どの店も遠い' },
    { id: 3, name: '日用品や救急セットは近くのお店にある' },
    { id: 4, name: 'だいたいの店は近い' }
  ]

  include ActiveHash::Associations
  has_many :users
end