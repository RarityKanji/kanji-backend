class AddCategoryToCollectibles < ActiveRecord::Migration[7.1]
  def change
    add_column :collectibles, :category, :string
  end
end
