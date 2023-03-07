class Request < ApplicationRecord
  belongs_to :user
  has_many :itineraries
  has_many :categories, through: :catreqs

  CATEGORIES = ["architecture", "parc", "street-art", "view", "urbex"]

end
