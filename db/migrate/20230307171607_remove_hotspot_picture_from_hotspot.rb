class RemoveHotspotPictureFromHotspot < ActiveRecord::Migration[7.0]
  def change
    remove_column :hotspots, :hotspot_picture
  end
end
