class AddNameToItineraries < ActiveRecord::Migration[7.0]
  def change
    add_column :itineraries, :name, :string, default: "Itinéraire n°"
  end
end
