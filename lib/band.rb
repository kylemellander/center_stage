class Band < ActiveRecord::Base
  has_many(:concerts)
  has_many(:venues, through: :concerts)
  validates(:name, presence: true)
end
