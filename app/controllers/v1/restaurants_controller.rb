module V1
    class RestaurantsController < ApplicationController

        def index
            
            @restaurants = Restaurant.all
            # json_response(@restaurants)
            render json: @restaurants, status: :ok, include: "**"
        end

        def show
            
            @restaurant = Restaurant.find(params[:id])
            
            render json: @restaurant, status: :ok, include: "**"
        end

        def create
            @restaurant = current_user.restaurants.create!(restaurant_params)
            @location = @restaurant.create_location(restaurant_params)
            @restaurant.update(location: @location)
            attach_cover(params[:cover]) if params[:cover]
            json_response(@restaurant, :created)
            
        end

        def update
            @restaurant = Restaurant.find(params[:id])
            @restaurant.update!(restaurant_params)
            @location = @restaurant.create_location(restaurant_params)
            @restaurant.update(location: @location)
            attach_cover(params[:cover]) if params[:cover]
            head :no_content
        end

        def destroy
            @restaurant = Restaurant.find(params[:id])
            @restaurant.destroy
            head :no_content
        end

        private

        def restaurant_params
            params.permit(:name, :address, :city, :country, :postcode, :category, :desc, :cuisine, :web, :start, :end)
        end

        def attach_cover(image)
            @restaurant.cover.attach(image)
            @uri = @restaurant.cover.service_url
            @restaurant.update(cover_uri: @uri)
        end
    end
end