class AddSelectedHotspotsIdToRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :selected_hotspots_id, :integer, array: true, default: []
  end
end
