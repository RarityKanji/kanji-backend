class Collectible < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    validates :price, presence: true
    validates :image, presence: true
    validates :description, presence: true
    validates :condition, presence: true
    validates :authenticity, presence: true
end
def update
    cat = CatFight.find(params[:id])
    cat.update(cat_params)
    if cat.valid?
      render json: cat
    else
      render json: cat.errors, status: 422
    end
  end

  def destroy
    cat = CatFight.find(params[:id])
    if cat.destroy
      render json: cat
    else
      render json: cat.errors, status: 422
    end
  end