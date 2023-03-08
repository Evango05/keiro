class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :distance
      t.float :longitude
      t.float :latitude
      t.string :constant_categories
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
