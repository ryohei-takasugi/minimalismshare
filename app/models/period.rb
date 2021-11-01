class Period < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '０日以下' },
    { id: 2, name: '数日' },
    { id: 3, name: '１ヶ月程度' },
    { id: 4, name: '３ヶ月程度' },
    { id: 5, name: '半年程度' },
    { id: 6, name: '１年程度' },
    { id: 7, name: '１年以上' }
  ]

  include ActiveHash::Associations
  has_many :experiences
end
