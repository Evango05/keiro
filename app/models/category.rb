class Category < ApplicationRecord
  has_many :hotcats
  has_many :hotspots, through: :hotcats
  NAMES = ["Architecture", "Street Art", "Point de vue", "Urbex", "Parc"]

end
