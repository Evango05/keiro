class Request < ApplicationRecord
  belongs_to :user
  has_many :itineraries
  has_many :categories, through: :catreqs

  CATEGORIES = ["Architecture", "Parc", "Street Art", "Point de vue", "Urbex"]
end
