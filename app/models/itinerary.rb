class Itinerary < ApplicationRecord
  belongs_to :request
  has_many :hotitis

  has_many :hotspots, through: :hotitis
end
