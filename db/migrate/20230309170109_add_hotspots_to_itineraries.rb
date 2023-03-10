class AddHotspotsToItineraries < ActiveRecord::Migration[7.0]
  def change
    add_column :itineraries, :selected_hotspot_ids, :string, array: true, default: []
    remove_column :requests, :selected_hotspots_id
  end
end
