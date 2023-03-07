class RemoveUserIdToItineraries < ActiveRecord::Migration[7.0]
  def change
    remove_column :itineraries, :user_id
  end
end
