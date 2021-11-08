class Region < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '北海道または東北' },
    { id: 2, name: '関東' },
    { id: 3, name: '中部' },
    { id: 4, name: '関西' },
    { id: 5, name: '中国または四国' },
    { id: 6, name: '九州または沖縄' }
  ]

  include ActiveHash::Associations
  has_many :users
end
