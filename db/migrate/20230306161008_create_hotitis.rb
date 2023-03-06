class CreateHotitis < ActiveRecord::Migration[7.0]
  def change
    create_table :hotitis do |t|
      t.references :hotspot, null: false, foreign_key: true
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
