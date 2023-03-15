class Itinerary < ApplicationRecord
  belongs_to :request
  has_many :hotitis

  def hotspots
    selected_hotspot_ids.map do |sh_id|
      Hotspot.find(sh_id)
    end
  end
end
