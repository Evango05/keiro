class CreateHotcats < ActiveRecord::Migration[7.0]
  def change
    create_table :hotcats do |t|
      t.references :category, null: false, foreign_key: true
      t.references :hotspot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
