class Category < ApplicationRecord
  has_many :hotcats
  has_many :hotspots, through: :hotcats
end
