require 'json'

module V1
    class RestaurantsController < ApplicationController
        def index
            @restaurants = Restaurant.all
            render json: @restaurants, status: :ok, include: "**"
        end

        def show
            
            @restaurant = Restaurant.find(params[:id])
            render json: @restaurant, status: :ok, include: "**"
        end

        def create
            params[:soc_med] = JSON.parse(params[:soc_med])
            @restaurant = current_user.restaurants.create!(restaurant_params)
            @location = @restaurant.create_location(restaurant_params)
            @restaurant.update(location: @location)
            attach_cover(params[:cover]) if ActiveRecord::Type::Boolean.new.cast(params[:cover])
            if current_user.admin
                @restaurant.update(approved: true)
            end
            json_response(@restaurant, :created)
            
        end

        def update
            @restaurant = Restaurant.find(params[:id])
            @restaurant.update!(restaurant_params)
            @location = @restaurant.create_location(restaurant_params)
            @restaurant.update(location: @location)
            attach_cover(params[:cover]) if ActiveRecord::Type::Boolean.new.cast(params[:cover])
            head :no_content
        end

        def destroy
            @restaurant = Restaurant.find(params[:id])
            @restaurant.destroy
            head :no_content
        end

        def approve
            @restaurant = Restaurant.find(params[:id])
            @restaurant.update!(approved: true)
            head :no_content
        end

        private

        def restaurant_params
            params.permit(
                :name, :address, :city, :country, :postcode, :category, :desc, 
                :cuisine, :web, :start, :end, :contact_number, {:soc_med => [:facebook, :instagram, :twitter]}, :family_friendly,
                :surau, :disabled_accessibility, :sub_header
            )
        end

        def attach_cover(image)
            @restaurant.cover.attach(image)
            @uri = url_for(@restaurant.cover)
            @restaurant.update(cover_uri: @uri)
        end
    end
end