class Collectible < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :price, presence: true
    validates :image, presence: true
    validates :description, presence: true
    validates :condition, presence: true
    validates :authenticity, presence: true
end