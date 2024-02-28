class AddConditionToCollectibles < ActiveRecord::Migration[7.1]
  def change
    add_column :collectibles, :condition, :string
    add_column :collectibles, :authenticity, :string
  end
end
