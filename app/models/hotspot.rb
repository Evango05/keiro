class Hotspot < ApplicationRecord
  has_many :hotcats
  has_many :hotitis

  has_many :categories, through: :hotcats
  has_many :itineraries, through: :hotitis

  has_one_attached :photo
end
