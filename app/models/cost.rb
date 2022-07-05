class Cost < ActiveHash::Base

  self.data = [
      {id: 0, range: '---'},
      {id: 1, range: '~5万円'}, {id: 2, range: '6~10万円'}, {id: 3, range: '11~20万円'},
      {id: 4, range: '21~30万円'}, {id: 5, range: '31~40万円'}, {id: 6, range: '41~50万円'},
      {id: 7, range: '51~70万円'}, {id: 8, range: '71~100万円'}, {id: 9, range: '100万円~'}
  ]
  include ActiveHash::Associations
  has_many :schools
end
