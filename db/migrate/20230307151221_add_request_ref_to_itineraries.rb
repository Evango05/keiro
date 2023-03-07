class AddRequestRefToItineraries < ActiveRecord::Migration[7.0]
  def change
    add_reference :itineraries, :request, null: false, foreign_key: true
  end
end
