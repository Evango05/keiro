class Hotspot < ApplicationRecord
  has_many :hotcats
  has_many :hotitis

  has_many :categories, through: :hotcats
  has_many :itineraries, through: :hotitis

  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def self.as_string(hotspots = nil)
    hotspots ||= all
    hotspots.map do |hotspot|
      "#{hotspot.longitude},#{hotspot.latitude}"
    end.join(";")
  end

  def self.from_categories(categories_names = nil)
    categories_names ||= Category::NAMES
    categories_names.map do |category_name|
      Category.find_by_name(category_name)
    end.map(&:hotspots).flatten.uniq
  end
end
