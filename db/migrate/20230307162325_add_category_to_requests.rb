class AddCategoryToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :category, :string, array: true
  end
end
