class AddRouteToItineraries < ActiveRecord::Migration[7.0]
  def change
    add_column :itineraries, :route, :json
  end
end
