class Venue < ActiveRecord::Base
  has_many(:concerts)
  has_many(:bands, through: :concerts)
  validates(:name, uniqueness: true)
  validates(:name, :city, :state, presence: true)
  validates(:state, length: {is: 2})
  before_save(:format_name, :format_city)

private

  def format_name
    venue_words = self.name.split(" ")
    updated_words = []
    venue_words.each do |word|
      updated_words.push(word.downcase.capitalize)
    end
    self.name = updated_words.join(" ")
  end

  def format_city
    venue_words = self.city.split(" ")
    updated_words = []
    venue_words.each do |word|
      updated_words.push(word.downcase.capitalize)
    end
    self.city = updated_words.join(" ")
  end

end
