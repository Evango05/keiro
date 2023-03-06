class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :hotitis

  has_many :hotspots, through: :hotitis
end
