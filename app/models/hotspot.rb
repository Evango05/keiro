class Hotspot < ApplicationRecord
  has_many :hotcats
  has_many :hotitis

  has_many :categories, through: :hotcats
  has_many :itineraries, through: :hotitis

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
