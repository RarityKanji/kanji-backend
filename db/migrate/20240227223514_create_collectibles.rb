class CreateCollectibles < ActiveRecord::Migration[7.1]
  def change
    create_table :collectibles do |t|
      t.string :name
      t.string :price
      t.text :image
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
