class CreateHotspots < ActiveRecord::Migration[7.0]
  def change
    create_table :hotspots do |t|
      t.string :name
      t.text :description
      t.string :hotspot_picture
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
