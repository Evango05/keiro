class RemoveConstantCategoriesFromRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :constant_categories, :string
  end
end
