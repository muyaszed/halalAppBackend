module V1
    class RestaurantsController < ApplicationController

        def index
            
            @restaurants = Restaurant.all
            json_response(@restaurants)
        end

        def show
            @restaurant = Restaurant.find(params[:id])
            
            json_response(@restaurant)
        end

        def create
            @restaurant = current_user.restaurants.create!(restaurant_params)
           
            json_response(@restaurant, :created)
            
        end

        def update
            @restaurant = Restaurant.find(params[:id])
            @restaurant.update(restaurant_params)
            head :no_content
        end

        def destroy
            @restaurant = Restaurant.find(params[:id])
            @restaurant.destroy
            head :no_content
        end

        private

        def restaurant_params
            params.permit(:name, :location, :category, :desc, :cuisine, :web, :start, :end)
        end
    end
end