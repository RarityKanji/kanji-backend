class CollectiblesController < ApplicationController
    def index
      if params[:category]
        collectibles = Collectible.where(category: params[:category])
      else
        collectibles = Collectible.all
      end
      render json: collectibles
    end
    
    def create
        collectible = Collectible.create(collectible_params)
        if collectible.valid?
          render json: collectible
        else
          render json: collectible.errors, status: 422
        end
    end

    def update
        collectible = Collectible.find(params[:id])
        collectible.update(collectible_params)
        if collectible.valid?
            render json: collectible
        else
            render json: collectible.errors, status: 422
        end
    end
    
    def destroy
        collectible = Collectible.find(params[:id])
        collectible.destroy
        head :no_content
      end

      private
      def collectible_params
        params.require(:collectible).permit(:name, :price, :image, :description, :condition, :authenticity, :category, :user_id)
      end
end
