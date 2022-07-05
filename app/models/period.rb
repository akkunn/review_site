class Period < ActiveHash::Base

  self.data = [
      {id: 0, range: '---'},
      {id: 1, range: '~1ヶ月'}, {id: 2, range: '2~3ヶ月'}, {id: 3, range: '4ヶ月~半年'},
      {id: 4, range: '7ヶ月~1年'}, {id: 5, range: '1年以上'}
  ]
  include ActiveHash::Associations
  has_many :schools
end
