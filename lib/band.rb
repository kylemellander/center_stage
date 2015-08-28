class Band < ActiveRecord::Base
  has_many(:concerts)
  has_many(:venues, through: :concerts)
  validates(:name, presence: true)
  before_save(:upcase_band)

private

  def upcase_band
    band_words = self.name.split(" ")
    updated_words = []
    band_words.each do |word|
      updated_words.push(word.downcase.capitalize)
    end
    self.name = updated_words.join(" ")
  end

end
