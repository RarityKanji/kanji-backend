class CollectiblesController < ApplicationController
    def index
        collectibles = Collectible.all
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
        if collectible.destroy
          render json: collectible
        end
    end

      private
      def collectible_params
        params.require(:collectible).permit(:name, :price, :image, :description, :condition, :authenticity, :user_id)
      end
end
