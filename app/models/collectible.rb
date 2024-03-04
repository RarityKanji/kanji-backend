class Collectible < ApplicationRecord
    belongs_to :user
    validates :name, :price, :image, :description, :condition, :authenticity, :category, presence: true
end